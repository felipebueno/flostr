import 'package:flostr/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    T viewModel,
    Widget? child,
  ) builder;
  final Function(T)? onViewModelReady;

  const BaseView({
    Key? key,
    required this.builder,
    this.onViewModelReady,
  }) : super(key: key);

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T viewModel = locator<T>();

  @override
  void initState() {
    viewModel.init();

    if (widget.onViewModelReady != null) {
      widget.onViewModelReady!(viewModel);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => viewModel,
      child: Consumer<T>(builder: widget.builder),
    );
  }

  @override
  void dispose() {
    try {
      viewModel.dispose();
    } catch (_) {}
    super.dispose();
  }
}
