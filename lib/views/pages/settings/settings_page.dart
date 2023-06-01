import 'package:flostr/views/base_view.dart';
import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flostr/views/pages/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(onViewModelReady: (model) {
      // Open wss connection
    }, builder: (context, model, __) {
      return BaseScaffold(
        title: 'Settings',
        body: StreamBuilder(
          stream: model.stream,
          builder: (context, snapshot) {
            return Text(snapshot.data.toString());
          },
        ),
      );
    });
  }
}
