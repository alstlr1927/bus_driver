import 'package:bus_counter/common/components/title_text_field/field_controller.dart';
import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/customer/repository/customer_repository.dart';
import 'package:bus_counter/customer/view/add_customer_screend.dart';
import 'package:bus_counter/customer/view/customer_modify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/customer_model.dart';

class CustomerListViewModel extends ChangeNotifier {
  State state;

  FieldController searchController = FieldController();

  List<CustomerModel> viewList = [];

  List<CustomerModel> allCustomerList = [];

  void onChanged(String val) {
    if (val.trim().isEmpty) {
      viewList = [...allCustomerList];
      notifyListeners();
    } else {
      List<CustomerModel> temp = allCustomerList
          .where((e) =>
              e.nickname.toLowerCase().contains(val.trim().toLowerCase()))
          .toList();
      viewList = [...temp];
      notifyListeners();
    }
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
        viewList = [...allCustomerList];
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
        viewList = [...allCustomerList];
        notifyListeners();
      }
    }
  }

  Future<void> onClickAddButton() async {
    await state.context.pushNamed(AddCustomerScreen.routeName);
    getAllCustomerList();
  }

  Future<void> getAllCustomerList() async {
    try {
      final res = await CustomerRepository().getCustomerList();

      List<CustomerModel> temp = res.map((e) {
        GonLog().i('res : $e');
        return CustomerModel.fromJson(e);
      }).toList();

      allCustomerList = [...temp];
      viewList = [...temp];
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
    super.dispose();
  }

  CustomerListViewModel(this.state) {
    getAllCustomerList().then((value) {
      viewList = [...allCustomerList];
      notifyListeners();
    });
  }
}
