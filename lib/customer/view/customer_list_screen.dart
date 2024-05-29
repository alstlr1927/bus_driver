import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/components/title_text_field/title_text_field.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/customer/components/customer_tile.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:bus_counter/customer/view_model/customer_list_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerListScreen extends StatefulWidget {
  static String get routeName => 'customer_list';

  final Function(CustomerModel)? onItemPressed;
  const CustomerListScreen({
    super.key,
    this.onItemPressed,
  });

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  late CustomerListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CustomerListViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomerListViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '고객 리스트',
          onPressed: viewModel.searchController.unfocus,
          actions: [_addButton()],
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: TitleTextField(
                  controller: viewModel.searchController,
                  hintText: '${tr('search_customer_hint')}',
                  onChanged: viewModel.onChanged,
                  onSubmitted: (v) => viewModel.searchController.unfocus(),
                ),
              ),
              SizedBox(height: 22.toWidth),
              Expanded(
                child: Selector<CustomerListViewModel, List<CustomerModel>>(
                  selector: (_, prov) => prov.viewList,
                  builder: (context, customerList, _) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: customerList.length,
                      itemBuilder: (context, index) {
                        final customer = customerList[index];
                        return CustomerTile(
                          customer: customer,
                          onPressed: widget.onItemPressed,
                          onUpdate: (customer) =>
                              viewModel.onClickUpdateButton(customer: customer),
                          onDelete: (customer) =>
                              viewModel.onClickDelteButton(customer: customer),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _addButton() {
    return BaseButton(
      onPressed: () => viewModel.onClickAddButton(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Icon(
          Icons.add,
          color: GonStyle.subBlue,
          size: 28.toWidth,
        ),
      ),
    );
  }
}
