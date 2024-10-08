import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/history/repository/history_repository.dart';
import 'package:bus_counter/login/view/login_landing_screen.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/custom_dialog/gon_dialog_land.dart';

enum FilterType {
  ALL('A', '전체'),
  COMPLETE('C', '완료'),
  DELETE('D', '삭제'),
  RUN('R', '진행중');

  const FilterType(this.code, this.kr);

  final String code;
  final String kr;
}

class HistoryViewModel extends ChangeNotifier {
  State state;

  List<RunModel> viewUserList = [];

  int pageLimit = 10;
  bool noMoreData = false;

  DocumentSnapshot? lastDoc;
  // List<RunModel> userCompleteList = [];
  // List<RunModel> userAllList = [];
  // List<RunModel> userDelteList = [];
  // List<RunModel> userRunList = [];

  // String selectedFilter = '전체';
  FilterType filterType = FilterType.ALL;

  void _initSetting() {
    viewUserList.clear();
    noMoreData = false;
    lastDoc = null;
  }

  void setFilter(int idx) {
    filterType = FilterType.values[idx];
    _initSetting();

    getHistoryData(
      state: filterType.code,
      isFirst: true,
    );
  }

  // void setUserList() {
  //   switch (selectedFilter) {
  //     case '완료':
  //       viewUserList = [...userCompleteList];
  //       break;
  //     case '전체':
  //       viewUserList = [...userAllList];
  //       break;
  //     case '삭제':
  //       viewUserList = [...userDelteList];
  //       break;
  //     case '진행중':
  //       viewUserList = [...userRunList];
  //       break;
  //   }
  //   notifyListeners();
  // }

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
      filterType = FilterType.ALL;
      notifyListeners();
      getHistoryData(state: FilterType.ALL.code, isFirst: true);
    }
  }

  Future<void> getHistoryData({
    required String state,
    bool isFirst = false,
  }) async {
    if (isFirst) {
      _initSetting();
    }
    if (noMoreData) return;

    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> res = [];
      if (filterType.code == 'A') {
        res = await HistoryRepository().getMyAllRunList(
          pageLimit: pageLimit,
          lastDoc: lastDoc,
        );
      } else {
        res = await HistoryRepository().getMyRunList(
          runState: state,
          pageLimit: pageLimit,
          lastDoc: lastDoc,
        );
      }

      GonLog().e('length : ${res.length}');
      if (res.length < pageLimit) {
        GonLog().i('no more data');
        noMoreData = true;
      }

      if (res.isNotEmpty) {
        lastDoc = res.last;
      }

      List<Map<String, dynamic>> parseDatas = res.map((e) {
        Map<String, dynamic> data = {};
        data = e.data();
        data['id'] = e.id;
        return data;
      }).toList();

      List<RunModel> temp =
          parseDatas.map((e) => RunModel.fromJson(e)).toList();

      viewUserList = [...viewUserList, ...temp];
      notifyListeners();
    } catch (e, trace) {
      GonLog().e('getHistoryData error : $e');
      GonLog().e('$trace');
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
