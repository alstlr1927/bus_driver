import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/customer/components/customer_tile.dart';
import 'package:bus_counter/customer/view_model/search_customer_result_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/customer_model.dart';

class SearchCustomerResultScreen extends StatefulWidget {
  static String get routeName => 'search_customer';

  final String nickname;
  final Function(CustomerModel)? onItemPressed;
  const SearchCustomerResultScreen({
    super.key,
    required this.nickname,
    this.onItemPressed,
  });

  @override
  State<SearchCustomerResultScreen> createState() =>
      _SearchCustomerResultScreenState();
}

class _SearchCustomerResultScreenState
    extends State<SearchCustomerResultScreen> {
  late SearchCustomerResultViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SearchCustomerResultViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchCustomerResultViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '검색결과',
          child: Selector<SearchCustomerResultViewModel, List<CustomerModel>>(
            selector: (_, prov) => prov.searchList,
            builder: (_, customerList, __) {
              return ListView.builder(
                itemCount: customerList.length,
                itemBuilder: (context, index) {
                  final customer = customerList[index];
                  return CustomerTile(
                    customer: customer,
                    onPressed: widget.onItemPressed,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
