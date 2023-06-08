import 'dart:convert';
import 'dart:io';

import 'package:flostr/data/models/profile.dart' as local_profile;
import 'package:flostr/utils/alerts.dart';
import 'package:flostr/utils/consts.dart';
import 'package:flostr/views/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ProfileViewModel extends BaseViewModel {
  WebSocketChannel? channel;

  Stream<Event>? get events => channel?.stream
      .map<Message>((data) => Message.deserialize(data))
      .where((message) => message.type == "EVENT")
      .map((message) => message.message as Event)
      .where((event) => event.isValid());

  Stream<local_profile.Profile>? get profiles => events
      ?.where((event) => event.kind == 0)
      .map((event) => jsonDecode(event.content))
      .map((content) => local_profile.Profile.fromJson(content));

  Future<void> updateProfile(local_profile.Profile profile) async {
    // TODO: Clean this fn up. Move socket connections to a service
    debugPrint('Saving profile $profile');
    final pk = await const FlutterSecureStorage().read(key: 'private-key');

    if (pk == null) {
      errorSnack('No private key found');

      return;
    }

    // TODO: Understand why saving through the WebSocketChannel doesn't work
    // Instantiate an event with a partial data and let the library sign the event with your private key
    // Event event = Event.from(
    //   kind: 0,
    //   tags: [],
    //   content: jsonEncode(profile.toJson()),
    //   privkey: Nip19.decodePrivkey(pk),
    // );

    // Send an event to the WebSocket server
    // channel?.sink.add(event.serialize());

    // TODO: dart.io doesn't work on web. Use WebSocketChannel instead
    final socket = await WebSocket.connect('wss://relay.damus.io');

    socket.listen((rawEvent) {
      // Print the PGP encrypted message here
      print(rawEvent);
    });

    Event event = Event.from(
      kind: 0,
      tags: [],
      content: jsonEncode(profile.toJson()),
      privkey: Nip19.decodePrivkey(pk),
    );

    socket.add(event.serialize());
    await socket.close();
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  @override
  Future<void> init() async {
    // TODO: Move to a service
    channel = WebSocketChannel.connect(Uri.parse('wss://relay.damus.io'));
    final encodedKey = await const FlutterSecureStorage().read(key: pubKey);
    if (encodedKey == null) {
      errorSnack('No public key found');

      return;
    }

    final decodedKey = Nip19.decodePubkey(encodedKey);

    debugPrint(
      'Listening for EVENTS from:\n\tencodedKey $encodedKey\n\tdecodedKey $decodedKey',
    );

    channel?.sink.add(
      Request(
        generate64RandomHexChars(),
        [
          Filter(
            kinds: [
              0,
              // 2,
              // 10002,
              // 3,
            ],
            authors: [decodedKey],
          ),
        ],
      ).serialize(),
    );
  }
}
