import 'package:flostr/utils/alerts.dart';
import 'package:flostr/utils/consts.dart';
import 'package:flostr/views/base_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SettingsViewModel extends BaseViewModel {
  WebSocketChannel? channel;

  Stream<dynamic>? get stream => channel?.stream;

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  @override
  Future<void> init() async {
    channel = WebSocketChannel.connect(Uri.parse('wss://relay.damus.io'));
    final key = await const FlutterSecureStorage().read(key: pubKey);
    if (key == null) {
      errorSnack('No public key found');

      return;
    }

    channel?.sink.add(
      Request(
        generate64RandomHexChars(),
        [
          Filter(
            kinds: [0],
            authors: [key],
          )
        ],
      ).serialize(),
    );
  }
}
