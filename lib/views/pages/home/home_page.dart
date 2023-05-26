import 'package:flostr/views/pages/home/the_wall.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TheWallWidget(
        channel: WebSocketChannel.connect(
          Uri.parse('wss://relay.damus.io'),
        ),
      ),
    );
  }
}
