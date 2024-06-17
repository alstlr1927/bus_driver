import 'package:bus_counter/common/helper/firbase_helper.dart';
import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/game/view/game_list_screen.dart';
import 'package:bus_counter/run/view/run_screen.dart';
import 'package:bus_counter/setting/view/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../customer/model/customer_model.dart';
import '../../customer/view/customer_detail_screen.dart';
import '../../customer/view/customer_list_screen.dart';
import '../../history/view/history_screen.dart';
import '../../login/view/login_landing_screen.dart';
import '../../manager/model/manager_model.dart';
import '../provider/profile_provider.dart';

class RootViewModel extends ChangeNotifier {
  State state;

  void onClickSettingButton() async {
    await state.context.pushNamed(SettingScreen.routeName);
  }

  void onClickGameListButton() async {
    await state.context.pushNamed(GameListScreen.routeName);
  }

  void onClickCounterButton() async {
    await state.context.pushNamed(RunScreen.routeName);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void onClickCustomerButton() async {
    await state.context.pushNamed(
      CustomerListScreen.routeName,
      extra: (CustomerModel customer) {
        state.context.pushNamed(
          CustomerDetailScreen.routeName,
          extra: customer,
        );
      },
    );
  }

  void onClickHistoryButton() async {
    await state.context.pushNamed(HistoryScreen.routeName);
  }

  void onClickLogoutButton() async {
    Provider.of<ProfileProvider>(state.context, listen: false)
        .updateProfileInfo(ManagerModel());
    FirebaseAuth.instance.signOut();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    state.context.goNamed(LoginLandingScreen.routeName);
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

  RootViewModel(this.state) {
    // _initRunCount();
    // _setRunCount();
    // _searchTest();
  }

  _searchTest() async {
    var allCustomerDatas =
        await FirestoreHelper().firestore.collection('customer').get();

    int cnt = 0;
    for (var customer in allCustomerDatas.docs) {
      cnt++;
      //
      // List<String> nicknameArr = [];
      String nickname = (customer.data()['nickname'] as String).toLowerCase();

      // for (int i = 0; i < nickname.length; i++) {
      //   String c = nickname[i];
      //   nicknameArr.add(c);
      // }
      GonLog().i('nicknameArr : ${nickname.split('')}');
      // await FirestoreHelper()
      //     .firestore
      //     .collection('customer')
      //     .doc(customer.id)
      //     .update({
      //   'nicknameArr': nicknameArr,
      // });

      GonLog().e('init run percent => $cnt / ${allCustomerDatas.docs.length}');
    }
  }

  _initRunCount() async {
    var allCustomerDatas =
        await FirestoreHelper().firestore.collection('customer').get();

    int cnt = 0;
    for (var customer in allCustomerDatas.docs) {
      cnt++;

      await FirestoreHelper()
          .firestore
          .collection('customer')
          .doc(customer.id)
          .update({
        'runCount': 0,
      });

      GonLog().e('init run percent => $cnt / ${allCustomerDatas.docs.length}');
    }
  }

  _setRunCount() async {
    var allRunDatas = await FirestoreHelper()
        .firestore
        .collection('run')
        .where('runState', isEqualTo: 'C')
        .get();
    int cnt = 0;
    for (var run in allRunDatas.docs) {
      cnt++;

      await FirestoreHelper()
          .firestore
          .collection('customer')
          .doc(run.data()['customerUid'])
          .update({
        'runCount': FieldValue.increment(run.data()['totalCount']),
      });

      GonLog().e('set run percent => $cnt / ${allRunDatas.docs.length}');
    }
  }
}
