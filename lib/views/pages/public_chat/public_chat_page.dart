import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flostr/views/pages/public_chat/tweet_wall.dart';
import 'package:flostr/views/widgets/send_message.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// TODO: Delete this page before publishing
class PublicChatPage extends StatelessWidget {
  const PublicChatPage({super.key});

  static const route = '/public-chat';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'The Wall',
      body: Builder(
        builder: (context) {
          final ws = WebSocketChannel.connect(
            Uri.parse('wss://relay.damus.io'),
          );

          return Column(
            children: [
              Expanded(child: TweetWall(ws)),
              SendMessage(ws),
            ],
          );
        },
      ),
    );
  }
}
