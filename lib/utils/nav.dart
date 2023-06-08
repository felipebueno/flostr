import 'package:flostr/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'consts.dart';

Future<void> pushReplacementNamed(String routeName) async {
  final context = FlostrApp.navigatorKey.currentState?.context;

  if (context == null) {
    return;
  }

  await Navigator.of(context).pushReplacementNamed(routeName);
}

Future<void> popAndPushReplacementNamed(String routeName) async {
  final context = FlostrApp.navigatorKey.currentState?.context;

  if (context == null) {
    return;
  }

  Navigator.of(context).pop();
  pushReplacementNamed(routeName);
}

Future<void> pushNamed(String routeName) async {
  final context = FlostrApp.navigatorKey.currentState?.context;

  if (context == null) {
    return;
  }

  await const FlutterSecureStorage().write(key: savedRoute, value: routeName);

  if (context.mounted) await Navigator.of(context).pushNamed(routeName);
}
