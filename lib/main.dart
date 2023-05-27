import 'package:flostr/views/pages/chats/chats_page.dart';
import 'package:flostr/views/pages/login/login_page.dart';
import 'package:flostr/views/pages/public_chat/public_chat_page.dart';
import 'package:flostr/views/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'views/pages/settings/settings_page.dart';

void main() {
  runApp(const FlostrApp());
}

class FlostrApp extends StatelessWidget {
  const FlostrApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  Widget _route(String? name) => switch (name) {
        SplashPage.route => const SplashPage(),
        LoginPage.route => const LoginPage(),
        ChatsPage.route => const ChatsPage(),
        PublicChatPage.route => const PublicChatPage(),
        SettingsPage.route => const SettingsPage(),
        _ => const SplashPage(),
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flostr',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings routeSettings) => MaterialPageRoute(
        settings: routeSettings,
        builder: (BuildContext context) => _route(routeSettings.name),
      ),
    );
  }
}
