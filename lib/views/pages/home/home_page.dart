import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(body: Placeholder());
  }
}
