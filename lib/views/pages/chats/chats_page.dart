import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: const Placeholder(),
      fab: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New'),
      ),
    );
  }
}
