import 'package:flutter/material.dart';

import '../view/customer_detail_screen.dart';

class CustomerDetailViewModel extends ChangeNotifier {
  State<CustomerDetailScreen> state;

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

  CustomerDetailViewModel(this.state);
}
