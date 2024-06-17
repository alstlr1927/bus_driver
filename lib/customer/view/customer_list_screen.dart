import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/components/title_text_field/text_field_theme/text_field_theme.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/customer/components/customer_tile.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:bus_counter/customer/view_model/customer_list_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
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
          onPressed: () => viewModel.searchNode.unfocus(),
          actions: [_addButton()],
          child: Column(
            children: [
              const _SearchBar(),
              SizedBox(height: 22.toWidth),
              _CustomerListWrapper(onItemPressed: widget.onItemPressed),
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

class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerListViewModel viewModel =
        Provider.of<CustomerListViewModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: TextFieldColor.textField_default_line,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: viewModel.searchController,
                focusNode: viewModel.searchNode,
                style: GonStyle.body2(
                  color: TextFieldColor.textField_text,
                ),
                decoration: InputDecoration(
                  hintText: '${tr('search_customer_hint')}',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintStyle: GonStyle.body2(
                      color: TextFieldColor.textField_hint_text,
                      weight: FontWeight.w600),
                ),
                onChanged: viewModel.onChanged,
                onSubmitted: (v) => viewModel.searchNode.unfocus(),
              ),
            ),
            BaseButton(
              onPressed: () {
                viewModel.onClickSearchButton();
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerListWrapper extends StatelessWidget {
  final Function(CustomerModel)? onItemPressed;
  const _CustomerListWrapper({
    Key? key,
    this.onItemPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerListViewModel viewModel =
        Provider.of<CustomerListViewModel>(context, listen: false);
    return Expanded(
      child: Selector<CustomerListViewModel, List<CustomerModel>>(
        selector: (_, prov) => prov.allCustomerList,
        builder: (context, customerList, _) {
          return LazyLoadScrollView(
            onEndOfPage: () {
              viewModel.getCustomerList();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: customerList.length,
              itemBuilder: (context, index) {
                final customer = customerList[index];
                return CustomerTile(
                  customer: customer,
                  onPressed: onItemPressed,
                  onUpdate: (customer) =>
                      viewModel.onClickUpdateButton(customer: customer),
                  onDelete: (customer) =>
                      viewModel.onClickDelteButton(customer: customer),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
