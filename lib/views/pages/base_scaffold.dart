import 'package:flostr/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'chats/chats_page.dart';
import 'login/login_page.dart';
import 'profile/profile_page.dart';
import 'public_chat/public_chat_page.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.body,
    this.title,
    this.fab,
  });

  final Widget? body;
  final String? title;
  final FloatingActionButton? fab;

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Flostr'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  'Flostr',
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            ListTile(
              selected: route == ChatsPage.route,
              leading: const Icon(Icons.chat),
              title: const Text('Chats'),
              onTap: () {
                popAndPushNamed(ChatsPage.route);
              },
            ),
            ListTile(
              selected: route == PublicChatPage.route,
              leading: const Icon(Icons.people),
              title: const Text('Pulic Wall'),
              onTap: () {
                popAndPushNamed(PublicChatPage.route);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                popAndPushNamed(ProfilePage.route);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await const FlutterSecureStorage().deleteAll();
                pushReplacementNamed(LoginPage.route);
              },
            ),
          ],
        ),
      ),
      body: body,
      floatingActionButton: fab,
    );
  }
}
