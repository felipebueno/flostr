import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flostr/views/pages/public_chat/tweet_card.dart';
import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TweetWall extends StatefulWidget {
  final WebSocketChannel channel;

  const TweetWall(this.channel, {super.key});

  @override
  TheWallState createState() => TheWallState();
}

class TheWallState extends State<TweetWall> {
  final List<Event> _events = [];
  final _spams = HashSet<String>();

  bool _isSpam(Event event) {
    var toHash = utf8.encode(event.content);
    String hash = sha256.convert(toHash).toString();
    if (_spams.contains(hash)) {
      debugPrint("${event.id} is a filtered spam");
      return true;
    }
    _spams.add(hash);

    return false;
  }

  @override
  void initState() {
    super.initState();
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

        try {
          Message msg = Message.deserialize(snapshot.data);
          if (msg.type == "EVENT") {
            Event event = msg.message;
            if (!_isSpam(event)) {
              _events.add(event);
              _events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            }
          }
        } catch (e, st) {
          // TODO: Do something with innvalid events
          debugPrintStack(
            stackTrace: st,
            label: 'Invalid Event',
          );
        }
        debugPrint(
          'events loaded: ${_events.length} spams filtered: ${_spams.length}',
        );

        return ListView.builder(
          shrinkWrap: true,
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];

            return TweetCard(
              avatar: 'https://robohash.org/${event.pubkey}?size=64x64',
              pubkey: event.pubkey,
              timestamp: event.createdAt,
              text: event.content,
            );
          },
        );
      },
    );
  }
}
