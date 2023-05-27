import 'package:flostr/main.dart';
import 'package:flutter/material.dart';

Future<void> infoSnack(String msg) async {
  final context = FlostrApp.navigatorKey.currentState?.context;

  if (context == null) {
    return;
  }

  final snackBar = SnackBar(content: Text(msg));
  final messenger = ScaffoldMessenger.of(context);

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(snackBar);
}

Future<void> errorSnack(String msg) async {
  final context = FlostrApp.navigatorKey.currentState?.context;

  if (context == null) {
    return;
  }

  final snackBar = SnackBar(
    content: Text(msg),
    backgroundColor: Colors.red,
  );
  final messenger = ScaffoldMessenger.of(context);

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(snackBar);
}
