import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/customer/repository/customer_repository.dart';
import 'package:flutter/material.dart';

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
