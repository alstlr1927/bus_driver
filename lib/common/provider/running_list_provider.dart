import 'package:bus_counter/common/repository/gon_repository.dart';
import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RunningListProvider extends ChangeNotifier {
  List<RunBase> runningList = [
    EmptyRun(),
    EmptyRun(),
    EmptyRun(),
  ];

  bool isSetRun = false;

  void countRunData({
    required RunModel copy,
    required int idx,
  }) async {
    if (isSetRun) return;
    isSetRun = true;
    runningList[idx] = copy;
    GonRepository().setCountRun(runId: copy.id);
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 600), () {
      isSetRun = false;
    });
  }

  void extendRunData({
    required RunModel copy,
    required int idx,
    required int count,
  }) async {
    if (isSetRun) return;
    isSetRun = true;
    runningList[idx] = copy;
    GonRepository().setExtendRun(
      runId: copy.id,
      count: count,
    );
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 600), () {
      isSetRun = false;
    });
  }

  Future<void> getRunningList() async {
    final manager = FirebaseAuth.instance.currentUser;
    if (manager != null) {
      final res = await GonRepository().getRunningList(managerUid: manager.uid);

      GonLog().i('length : ${res.length}');
      GonLog().i('data : ${res}');

      List<RunModel> temp = res.map((e) => RunModel.fromJson(e)).toList();

      for (int i = 0; i < 3; i++) {
        if (i < temp.length) {
          runningList[i] = temp[i];
        } else {
          runningList[i] = EmptyRun();
        }
      }

      GonLog().i('running : ${runningList}');
      notifyListeners();
    }
  }
}
