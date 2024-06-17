import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/customer/repository/customer_repository.dart';
import 'package:bus_counter/customer/view/add_customer_screend.dart';
import 'package:bus_counter/customer/view/customer_modify_screen.dart';
import 'package:bus_counter/customer/view/search_customer_result_screen.dart';
import 'package:bus_counter/router/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/customer_model.dart';
import '../view/customer_list_screen.dart';

class CustomerListViewModel extends ChangeNotifier {
  State<CustomerListScreen> state;

  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  String keyword = '';

  List<CustomerModel> allCustomerList = [];

  bool isSearchMode = false;

  int pageLimit = 20;
  bool noMoreData = false;

  DocumentSnapshot? lastDoc;

  void _initSetting() {
    noMoreData = false;
    lastDoc = null;
  }

  Future<void> onClickSearchButton() async {
    if (keyword.isEmpty) return;
    Map<String, dynamic> data = {};
    if (GoRouterObserver().getHistories().contains('add_user')) {
      data = {
        'nickname': keyword,
        'onItemPressed': (CustomerModel customer) {
          state.widget.onItemPressed?.call(customer);
          state.context.pop();
        },
      };
    } else {
      data = {
        'nickname': keyword,
        'onItemPressed': (CustomerModel customer) {
          state.widget.onItemPressed?.call(customer);
        },
      };
    }

    await state.context.pushNamed(
      SearchCustomerResultScreen.routeName,
      extra: data,
    );
  }

  void onChanged(String val) {
    keyword = val.trim();
    notifyListeners();
  }

  Future<void> onClickDelteButton({
    required CustomerModel customer,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await CustomerRepository().deleteCustomer(
        customerUid: customer.uid,
        nickname: customer.nickname,
        managerUid: user.uid,
      );
      int idx = allCustomerList.indexWhere((e) => e.uid == customer.uid);
      if (idx != -1) {
        allCustomerList.removeAt(idx);
        notifyListeners();
      }
    } catch (e, trace) {
      GonLog().e('deleteCustomer error : $e');
      GonLog().e('$trace');
    }
  }

  Future<void> onClickUpdateButton({required CustomerModel customer}) async {
    final result = await state.context.pushNamed(
      CustomerModifyScreen.routeName,
      extra: customer,
    );

    if (result is CustomerModel) {
      int idx = allCustomerList.indexWhere((e) => e.uid == result.uid);
      if (idx != -1) {
        allCustomerList[idx] = result;
        notifyListeners();
      }
    }
  }

  Future<void> onClickAddButton() async {
    await state.context.pushNamed(AddCustomerScreen.routeName);
    getCustomerList(isFirst: true);
  }

  Future<void> getCustomerList({
    bool isFirst = false,
  }) async {
    if (isFirst) {
      _initSetting();
    }
    if (noMoreData) return;
    try {
      final res = await CustomerRepository().getCustomerList(
        pageLimit: pageLimit,
        lastDoc: lastDoc,
      );
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
        data['uid'] = e.id;
        return data;
      }).toList();

      List<CustomerModel> temp = parseDatas.map((e) {
        return CustomerModel.fromJson(e);
      }).toList();

      allCustomerList = [...allCustomerList, ...temp];
      notifyListeners();
    } catch (e, trace) {
      GonLog().e('getAllCustomerList error : $e');
      GonLog().e('$trace');
    }
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    searchNode.dispose();
    super.dispose();
  }

  CustomerListViewModel(this.state) {
    getCustomerList(isFirst: true);
  }
}
