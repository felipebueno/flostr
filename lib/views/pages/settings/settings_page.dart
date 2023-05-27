import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      title: 'Settings',
      body: Placeholder(),
    );
  }
}
