import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/login/repository/login_repository.dart';
import 'package:bus_counter/manager/model/manager_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  ManagerModel _manager = ManagerModel();

  ManagerModel get manager => _manager;

  bool get isLogin => _manager.uid.isNotEmpty;

  String get nickname => _manager.nickname;

  String get profileImage => _manager.profileImageUrl;

  String get grade => getGrade();

  String getGrade() {
    if (_manager.grade.isEmpty) {
      return 'normal';
    } else {
      return _manager.grade;
    }
  }

  void updateProfileInfo(ManagerModel copy) {
    _manager = copy;
    notifyListeners();
  }

  Future<ManagerModel> refreshProfile() async {
    try {
      final res = await LoginRepository().getUserByUid(uid: _manager.uid);
      if (res != null && res.exists) {
        var data = ManagerModel.fromJson(res.data()!);
        updateProfileInfo(data);
        return data;
      }
      return ManagerModel();
    } catch (e, trace) {
      GonLog().e('refreshProfile error : $e');
      GonLog().e('$trace');
      return ManagerModel();
    }
  }
}
