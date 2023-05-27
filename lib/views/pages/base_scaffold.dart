import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home/home_page.dart';
import 'login/login_page.dart';
import 'public_chat/public_chat_page.dart';
import 'settings/settings_page.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.body,
    this.title,
  });

  final Widget? body;
  final String? title;

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
              child: const Text('Flostr'),
            ),
            ListTile(
              selected: route == HomePage.route,
              leading: const Icon(Icons.chat),
              title: const Text('Chats'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(HomePage.route);
              },
            ),
            ListTile(
              selected: route == PublicChatPage.route,
              leading: const Icon(Icons.people),
              title: const Text('Pulic Wall'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(PublicChatPage.route);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(SettingsPage.route);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await const FlutterSecureStorage().deleteAll();
                // TODO: Don't use build context across async gaps
                Navigator.of(context).pushReplacementNamed(LoginPage.route);
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
