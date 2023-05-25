import 'package:flostr/views/pages/home/home_page.dart';
import 'package:flostr/views/pages/login/login_page.dart';
import 'package:flostr/views/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flostr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFFF2A900)),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings routeSettings) => MaterialPageRoute(
        settings: routeSettings,
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            case SplashPage.routeName:
              return const SplashPage();
            case LoginPage.routeName:
              return const LoginPage();
            case HomePage.routeName:
              return const HomePage();
            default:
              return const SplashPage();
          }
        },
      ),
    );
  }
}
