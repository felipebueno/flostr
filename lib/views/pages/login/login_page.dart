import 'package:flostr/utils/alerts.dart';
import 'package:flostr/utils/consts.dart';
import 'package:flostr/utils/nav.dart';
import 'package:flostr/views/pages/chats/chats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nostr/nostr.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _privkeyController = TextEditingController();
  final _pubkeyController = TextEditingController();

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
              controller: _privkeyController,
              onChanged: (value) {
                if (value.length != 64) {
                  setState(() {
                    _pubkeyController.text = '';
                  });

                  return;
                }

                final encodedPublicKey =
                    Nip19.encodePubkey(Keychain(value).public);

                setState(() {
                  _pubkeyController.text = encodedPublicKey;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Private Key',
                icon: Icon(Icons.close),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: _pubkeyController.text));

                infoSnack('Public key copied to clipboard');
              },
              child: TextField(
                controller: _pubkeyController,
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Public Key',
                  icon: Icon(Icons.key_outlined),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                if (_privkeyController.text.isEmpty ||
                    _pubkeyController.text.isEmpty) {
                  return;
                }

                final pk = _privkeyController.text;

                if (pk.isEmpty) {
                  return;
                }

                final privateKey = Nip19.encodePrivkey(pk);

                // TODO: Validate keys before saving

                // TODO: Get profile details from relay

                await const FlutterSecureStorage().write(
                  key: privKey,
                  value: privateKey,
                );
                await const FlutterSecureStorage().write(
                  key: pubKey,
                  value: _pubkeyController.text,
                );

                pushReplacementNamed(ChatsPage.route);
              },
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
            const Text('relay.damus.io', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final k = Keychain.generate();
          setState(() {
            _privkeyController.text = k.private;
            _pubkeyController.text = k.public;
          });
        },
        label: const Text('Generate New Key'),
        icon: const Icon(Icons.key),
      ),
    );
  }
}
