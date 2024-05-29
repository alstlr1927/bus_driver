import 'package:bus_counter/common/components/title_text_field/field_controller.dart';
import 'package:bus_counter/common/provider/running_list_provider.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:bus_counter/login/view/login_landing_screen.dart';
import 'package:bus_counter/run/repository/run_repository.dart';
import 'package:bus_counter/run/view/add_run_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/components/custom_dialog/hobby_dialog.dart';
import '../../game/model/game_model.dart';

class AddRunViewModel extends ChangeNotifier {
  State<AddRunScreen> state;

  FieldController nameController = FieldController();
  TextEditingController cntController = TextEditingController(text: '10');
  FocusNode cntNode = FocusNode();

  CustomerModel? customer;
  GameModel game = GameModel(name: '문양작');

  String name = '';
  int count = 10;

  void setCustomer(CustomerModel model) {
    customer = model;
    notifyListeners();
  }

  void setGame(GameModel model) {
    game = model;
    notifyListeners();
  }

  void setCount(int val) {
    if (count + val < 0) {
      count = 0;
    } else {
      count += val;
    }
    cntController.text = '$count';
    notifyListeners();
  }

  void onChanged(String val) {
    if (val.isNotEmpty) {
      int value = int.parse(val);
      print('value : ${value}');
    } else {
      count = 0;
      cntController.text = '0';
    }
    notifyListeners();
  }

  Future<void> onClickRegistBtn() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // 다시 로그인 해주세요
      await _alertDialog(title: '${tr('retry_login_dialog_title')}');
      FirebaseAuth.instance.signOut();
      state.context.goNamed(LoginLandingScreen.routeName);
      return;
    }
    if (customer == null) return;
    await RunRepository().createRun(
      customerName: customer!.nickname,
      customerUid: customer!.uid,
      managerUid: user.uid,
      totalCount: count,
      gameName: game.name,
    );

    await RunRepository()
        .addCustomerGame(customerUid: customer!.uid, gameName: game.name);

    Provider.of<RunningListProvider>(state.context, listen: false)
        .getRunningList();
    state.context.pop();
  }

  void focusoutAll() {
    nameController.unfocus();
    cntNode.unfocus();
  }

  Future<void> _alertDialog({required String title}) async {
    await showDialog(
      context: state.context,
      builder: (context) {
        return GonDialog(
          title: '${tr('app_ko_title')}',
          content: '$title',
          itemList: [
            GonDialogBtnItem(
              title: '${tr('confirm_btn_title')}',
              onPressed: () {
                state.context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    cntController.dispose();
    cntNode.dispose();
    super.dispose();
  }

  AddRunViewModel(this.state);
}
