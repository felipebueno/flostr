import 'package:flostr/views/pages/home/send_message.dart';
import 'package:flostr/views/pages/home/tweet_wall.dart';
import 'package:flostr/views/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Wall'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await const FlutterSecureStorage().deleteAll();
              // TODO: Don't use build context across async gaps
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            },
          )
        ],
      ),
      body: Builder(builder: (context) {
        final ws = WebSocketChannel.connect(
          Uri.parse('wss://relay.damus.io'),
        );

        return Column(
          children: [
            Expanded(
              child: TweetWall(ws),
            ),
            SendMessage(ws),
          ],
        );
      }),
    );
  }
}
