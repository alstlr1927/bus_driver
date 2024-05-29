import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:bus_counter/customer/view_model/customer_detail_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDetailScreen extends StatefulWidget {
  static String get routeName => 'customer_detail';

  final CustomerModel customer;
  const CustomerDetailScreen({
    super.key,
    required this.customer,
  });

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  late CustomerDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CustomerDetailViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomerDetailViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: widget.customer.nickname,
          // actions: [_buildMoreWidget()],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.toWidth),
            child: Column(
              children: [
                SizedBox(height: 30.toWidth),
                _buildTextWidget(
                  title: '${tr('run_count_title')}',
                  content: '${widget.customer.runCount}',
                ),
                SizedBox(height: 14.toWidth),
                _buildTextWidget(
                  title: '${tr('game_title')}',
                  content: '${widget.customer.gameList}',
                ),
                SizedBox(height: 14.toWidth),
                _buildTextWidget(
                  title: '${tr('email_title')}',
                  content: '${widget.customer.email}',
                ),
                SizedBox(height: 14.toWidth),
                _buildTextWidget(
                  title: '${tr('phone_title')}',
                  content: '${widget.customer.phone}',
                ),
                SizedBox(height: 14.toWidth),
                _buildTextWidget(
                  title: '${tr('regist_date_title')}',
                  content: '${getDateTimeToString(widget.customer.createdAt)}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _buildMoreWidget() {
  //   return CupertinoButton(
  //     onPressed: () => viewModel.onClickMore(),
  //     child: Icon(
  //       Icons.more_vert_rounded,
  //       color: Colors.black,
  //     ),
  //   );
  // }

  String getDateTimeToString(DateTime dt) {
    String dtStr = DateFormat('yyyy.MM.dd').format(dt);
    return dtStr;
  }

  Widget _buildTextWidget({
    required String title,
    required String content,
  }) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 12.toWidth),
      decoration: BoxDecoration(
        color: GonStyle.white,
        boxShadow: GonStyle.elevation_01dp(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            '$title :',
            style: GonStyle.body2(
              weight: FontWeight.w600,
              color: GonStyle.gray070,
            ),
          ),
          Spacer(),
          Text(
            '$content',
            style: GonStyle.body2(
              weight: FontWeight.w600,
              color: GonStyle.gray070,
            ),
          ),
        ],
      ),
    );
  }
}
