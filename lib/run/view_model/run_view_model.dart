import 'package:bus_counter/common/provider/running_list_provider.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:bus_counter/run/view/add_run_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RunViewModel extends ChangeNotifier {
  State state;

  Future<void> onClickCountButton({
    required RunModel item,
    required int idx,
  }) async {
    if (item.remainingCount < 1) return;
    Provider.of<RunningListProvider>(state.context, listen: false).countRunData(
      copy: item.copyWith(
        remainingCount: item.remainingCount - 1,
        completedCount: item.completedCount + 1,
      ),
      idx: idx,
    );
  }

  Future<void> extendRunCount({
    required RunModel item,
    required int count,
    required int idx,
  }) async {
    Provider.of<RunningListProvider>(state.context, listen: false)
        .extendRunData(
      copy: item.copyWith(
        remainingCount: item.remainingCount + count,
        totalCount: item.totalCount + count,
      ),
      count: count,
      idx: idx,
    );
  }

  Future<void> onClickEmptyUser() async {
    await state.context.pushNamed(AddRunScreen.routeName);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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

  RunViewModel(this.state) {
    // get user state run
    Provider.of<RunningListProvider>(state.context, listen: false)
        .getRunningList();
  }
}
