import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/customer/repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/customer_model.dart';
import '../view/search_customer_result_screen.dart';

class SearchCustomerResultViewModel extends ChangeNotifier {
  State<SearchCustomerResultScreen> state;

  List<CustomerModel> searchList = [];

  Future<void> getSearchCustomer() async {
    List<String> nickArr = state.widget.nickname.split('');
    try {
      var res = await CustomerRepository().searchCustomer(nickArr: nickArr);
      List<CustomerModel> temp =
          res.map((e) => CustomerModel.fromJson(e)).toList();
      searchList = [...temp];
      GonLog().i('searchList length : ${searchList.length}');
      notifyListeners();
    } catch (e, trace) {
      GonLog().e('getSearchCustomer error : $e');
      GonLog().e('$trace');
    }
  }

  Future<void> onClickDeleteButton({
    required CustomerModel customer,
  }) async {
    try {
      await state.widget.onDelete?.call(customer);
      searchList = searchList.where((e) => e.uid != customer.uid).toList();
      notifyListeners();
      // int idx = searchList.indexWhere((e) => e.uid == customer.uid);
      // GonLog().i('idx : $idx');
      // if (idx != -1) {
      //   searchList.removeAt(idx);
      //   notifyListeners();
      // }
    } catch (e, trace) {
      GonLog().e('deleteCustomer error : $e');
      GonLog().e('$trace');
    }
  }

  Future<void> onClickUpdateButton({required CustomerModel customer}) async {
    await state.widget.onUpdate?.call(customer);
    // var result = null;
    state.context.pop();

    // GonLog().i('result : ${result}');

    // if (result is CustomerModel) {
    //   GonLog().i('result : ${result.toJson()}');
    //   searchList = searchList.map(
    //     (e) {
    //       if (e.uid == result.uid) {
    //         return result;
    //       }
    //       return e;
    //     },
    //   ).toList();
    //   notifyListeners();
    //   // int idx = searchList.indexWhere((e) => e.uid == result.uid);
    //   // if (idx != -1) {
    //   //   searchList[idx] = result;
    //   //   notifyListeners();
    //   // }
    // }
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

  SearchCustomerResultViewModel(this.state) {
    getSearchCustomer();
  }
}
