import 'package:flostr/utils/nav.dart';
import 'package:flostr/views/pages/chats/chats_page.dart';
import 'package:flostr/views/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _checkAuth() async {
    String? key = await const FlutterSecureStorage().read(key: 'private-key');

    if (key == null) {
      pushReplacementNamed(LoginPage.route);

      return;
    }

    pushReplacementNamed(ChatsPage.route);
  }

  @override
  void initState() {
    super.initState();

    _checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
