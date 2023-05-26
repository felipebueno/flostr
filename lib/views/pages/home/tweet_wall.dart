import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flostr/views/pages/home/tweet_card.dart';
import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

var spams = HashSet<String>();

bool isSpam(Event event) {
  var toHash = utf8.encode(event.content);
  String hash = sha256.convert(toHash).toString();
  if (spams.contains(hash)) {
    debugPrint("${event.id} is a filtered spam");
    return true;
  }
  spams.add(hash);
  return false;
}

class TweetWall extends StatefulWidget {
  final WebSocketChannel channel;

  const TweetWall(this.channel, {super.key});

  @override
  TheWallState createState() => TheWallState();
}

class TheWallState extends State<TweetWall> {
  final List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    spams.clear();
    debugPrint('Connected to WebSocket');
    widget.channel.sink.add(
      Request(
        generate64RandomHexChars(),
        [
          Filter(
            kinds: [1],
            since: currentUnixTimestampSeconds() - 86400,
          )
        ],
      ).serialize(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.channel.stream,
      builder: (context, snapshot) {
        debugPrint(snapshot.connectionState.name);
        debugPrint(snapshot.data);

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        Message msg = Message.deserialize(snapshot.data);
        if (msg.type == "EVENT") {
          Event event = msg.message;
          if (!isSpam(event)) {
            _events.add(event);
            _events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          }
        }
        // debugPrint(
        //   'events loaded: ${_events.length} spams filtered: ${spams.length}',
        // );

        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: _events.length,
          itemBuilder: (context, index) {
            return TweetCard(
              avatar: '',
              pubkey: _events[index].pubkey,
              timestamp: _events[index].createdAt,
              text: _events[index].content,
            );
          },
        );
      },
    );
  }
}
