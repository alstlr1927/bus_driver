import 'package:flutter/material.dart';

class LoginLandingViewModel extends ChangeNotifier {
  State state;

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  LoginLandingViewModel(this.state);
}
