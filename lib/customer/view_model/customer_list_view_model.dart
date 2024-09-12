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
    allCustomerList.clear();
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
        'onDelete': (CustomerModel customer) async {
          await onClickDelteButton(customer: customer);
        },
        'onUpdate': (CustomerModel customer) async {
          await onClickUpdateButton(customer: customer);
        },
      };
    } else {
      data = {
        'nickname': keyword,
        'onItemPressed': (CustomerModel customer) {
          state.widget.onItemPressed?.call(customer);
        },
        'onDelete': (CustomerModel customer) async {
          await onClickDelteButton(customer: customer);
        },
        'onUpdate': (CustomerModel customer) async {
          await onClickUpdateButton(customer: customer);
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
      allCustomerList =
          allCustomerList.where((e) => e.uid != customer.uid).toList();
      notifyListeners();
    } catch (e, trace) {
      GonLog().e('deleteCustomer error : $e');
      GonLog().e('$trace');
    }
  }

  Future onClickUpdateButton({required CustomerModel customer}) async {
    final result = await state.context.pushNamed(
      CustomerModifyScreen.routeName,
      extra: customer,
    );

    if (result is CustomerModel) {
      allCustomerList = allCustomerList.map(
        (e) {
          if (e.uid == result.uid) {
            return result;
          }
          return e;
        },
      ).toList();
      notifyListeners();
    }

    return result;
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
