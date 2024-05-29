import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/history/repository/history_repository.dart';
import 'package:bus_counter/login/view/login_landing_screen.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/custom_dialog/gon_dialog_land.dart';

enum FilterType {
  COMPLETE('C', '완료'),
  ALL('A', '전체'),
  DELETE('D', '삭제'),
  RUN('R', '진행중');

  const FilterType(this.code, this.kr);

  final String code;
  final String kr;
}

class HistoryViewModel extends ChangeNotifier {
  State state;

  List<RunModel> viewUserList = [];
  List<RunModel> userCompleteList = [];
  List<RunModel> userAllList = [];
  List<RunModel> userDelteList = [];
  List<RunModel> userRunList = [];

  String selectedFilter = '전체';

  void setFilter(int idx) {
    selectedFilter = FilterType.values[idx].kr;
    setUserList();
  }

  void setUserList() {
    switch (selectedFilter) {
      case '완료':
        viewUserList = [...userCompleteList];
        break;
      case '전체':
        viewUserList = [...userAllList];
        break;
      case '삭제':
        viewUserList = [...userDelteList];
        break;
      case '진행중':
        viewUserList = [...userRunList];
        break;
    }
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

  HistoryViewModel(this.state) {
    _initData();
  }

  Future<void> _initData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await _alertDialog(
        title: '${tr('retry_login_dialog_title')}',
        confirm: () {
          state.context.pop();
        },
      );
      state.context.go(LoginLandingScreen.routeName);
    } else {
      Future.wait([
        getHistoryData(uid: user.uid, state: 'C')
            .then((value) => userCompleteList = value),
        getHistoryData(uid: user.uid, state: 'A')
            .then((value) => userAllList = value),
        getHistoryData(uid: user.uid, state: 'D')
            .then((value) => userDelteList = value),
        getHistoryData(uid: user.uid, state: 'R')
            .then((value) => userRunList = value),
      ]).then((value) {
        viewUserList = [...userCompleteList];
        notifyListeners();
      });
    }
  }

  Future<List<RunModel>> getHistoryData({
    required String uid,
    required String state,
  }) async {
    try {
      final res = await HistoryRepository().getMyRunList(
        managerUid: uid,
        runState: state,
      );
      GonLog().e('length : ${res.length}');
      final temp = res.map((e) => RunModel.fromJson(e)).toList();
      return temp;
      // userList = [...temp];
      // notifyListeners();
    } catch (e, trace) {
      GonLog().e('getHistoryData error : $e');
      GonLog().e('$trace');
      return [];
    }
  }

  Future<void> _alertDialog({
    required String title,
    VoidCallback? confirm,
  }) async {
    await showDialog(
      context: state.context,
      builder: (context) {
        return GonDialogLand(
          title: '${tr('app_ko_title')}',
          content: '$title',
          itemList: [
            GonDialogBtnItem(
              title: '${tr('confirm_btn_title')}',
              onPressed: () {
                confirm?.call();
              },
            ),
          ],
        );
      },
    );
  }
}
