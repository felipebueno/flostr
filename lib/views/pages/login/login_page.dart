import 'package:flostr/views/pages/chats/chats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nostr/nostr.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 160, style: FlutterLogoStyle.stacked),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Private Key',
                icon: Icon(Icons.key_outlined),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final pk = _controller.text;

                if (pk.isEmpty) {
                  return;
                }

                // TODO: Check if private key is valid before saving it

                await const FlutterSecureStorage().write(
                  key: 'private-key',
                  value: pk,
                );

                // TODO: Don't use build context across async gaps
                Navigator.of(context).pushReplacementNamed(ChatsPage.route);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final k = Keychain.generate();
          setState(() {
            _controller.text = k.private;
          });
        },
        label: const Text('Generate New Key'),
        icon: const Icon(Icons.key),
      ),
    );
  }
}
