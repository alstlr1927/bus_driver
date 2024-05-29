import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingViewModel extends ChangeNotifier {
  State state;

  String version = '';

  Future<void> _getCurVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    notifyListeners();
  }

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

  SettingViewModel(this.state) {
    _getCurVersion();
  }
}
