import 'package:flostr/views/pages/home/home_page.dart';
import 'package:flostr/views/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _checkAuth() async {
    String? key = await const FlutterSecureStorage().read(key: 'private-key');

    if (key == null) {
      // TODO: Don't use build context across async gaps
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);

      return;
    }

    // TODO: Check if private key is valid
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
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
