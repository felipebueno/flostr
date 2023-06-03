import 'dart:convert';

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

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  @override
  Future<void> init() async {
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
              2,
              10002,
              3,
            ],
            authors: [decodedKey],
          ),
        ],
      ).serialize(),
    );
  }
}
