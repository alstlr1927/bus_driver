import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/components/bottom_sheet/bottom_sheet_picker.dart';
import '../../common/components/bottom_sheet/show_modal_sheet.dart';
import '../../common/utils/gon_style.dart';

class CustomerTile extends StatelessWidget {
  final CustomerModel customer;
  final Function(CustomerModel)? onPressed;
  final Function(CustomerModel)? onDelete;
  final Function(CustomerModel)? onUpdate;
  const CustomerTile({
    super.key,
    required this.customer,
    this.onDelete,
    this.onUpdate,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: () {
        onPressed?.call(customer);
      },
      child: GestureDetector(
        onLongPress: () => onClickMore(context),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: 10.toWidth, horizontal: 16.toWidth),
          padding: EdgeInsets.symmetric(
              horizontal: 20.toWidth, vertical: 16.toWidth),
          decoration: BoxDecoration(
            color: GonStyle.white,
            boxShadow: GonStyle.elevation_04dp(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                '${customer.nickname}',
                style: GonStyle.body2(
                  weight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${customer.runCount} 회',
                style: GonStyle.body2(
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickMore(BuildContext context) {
    List<BottomSheetItem> options = [];
    options = [
      BottomSheetItem(
        title: '${tr('modify_btn_title')}',
        cautionFlag: false,
        onPressed: () async {
          onUpdate?.call(customer);
        },
      ),
      BottomSheetItem(
        title: '${tr('delete_btn_title')}',
        cautionFlag: true,
        onPressed: () {
          onDelete?.call(customer);
        },
      ),
    ];
    showModalPopUp(
        context: context,
        builder: (context) {
          return BottomSheetPicker(
            actions: options,
            cancelItem: BottomSheetItem(title: '${tr('cancel_btn_title')}'),
          );
        });
  }
}
