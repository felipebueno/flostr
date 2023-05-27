import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flostr/views/pages/public_chat/tweet_wall.dart';
import 'package:flostr/views/widgets/send_message.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// TODO: Delete this page before publishing
class PublicChatPage extends StatefulWidget {
  const PublicChatPage({super.key});

  static const route = '/public-chat';

  @override
  State<PublicChatPage> createState() => _PublicChatPageState();
}

class _PublicChatPageState extends State<PublicChatPage> {
  final channel = WebSocketChannel.connect(Uri.parse('wss://relay.damus.io'));

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'The Wall',
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              Expanded(child: TweetWall(channel)),
              SendMessage(channel),
            ],
          );
        },
      ),
    );
  }
}
