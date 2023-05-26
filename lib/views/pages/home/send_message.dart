import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SendMessage extends StatefulWidget {
  const SendMessage(this.channel, {super.key});

  final WebSocketChannel channel;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final _controller = TextEditingController();

  Future<void> _sendMessage(String text) async {
    final pk = await const FlutterSecureStorage().read(key: 'private-key');

    if (pk == null) {
      // TODO: Show error alert
      debugPrint('No private key found');

      return;
    }

    // Instantiate an event with a partial data and let the library sign the event with your private key
    Event event = Event.from(
      kind: 1,
      tags: [],
      content: text,
      privkey: pk,
    );

    // Send an event to the WebSocket server
    widget.channel.sink.add(event.serialize());

    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        controller: _controller,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Message',
          suffixIcon: IconButton(
            onPressed: _controller.text.isEmpty
                ? null
                : () {
                    _sendMessage(_controller.text);
                  },
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}