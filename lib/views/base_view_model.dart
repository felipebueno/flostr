import 'package:flutter/widgets.dart';

enum ViewState {
  idle,
  busy,
}

abstract class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  bool get isBusy => _state == ViewState.busy;
  void setState(ViewState viewState) {
    _state = viewState;

    try {
      notifyListeners();
    } catch (_) {}
  }

  Future<void> init() async {}

  bool get validate => true;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
