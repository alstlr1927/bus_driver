import 'package:bus_counter/common/components/custom_button/custom_button.dart';
import 'package:bus_counter/common/components/title_text_field/title_text_field.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:bus_counter/customer/view_model/customer_modify_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/utils/gon_style.dart';

class CustomerModifyScreen extends StatefulWidget {
  static String get routeName => 'customer_modify';

  final CustomerModel customer;
  const CustomerModifyScreen({
    super.key,
    required this.customer,
  });

  @override
  State<CustomerModifyScreen> createState() => _CustomerModifyScreenState();
}

class _CustomerModifyScreenState extends State<CustomerModifyScreen> {
  late CustomerModifyViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CustomerModifyViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomerModifyViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('modify_customer_title')}',
          onPressed: viewModel.focusoutAll,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Column(
              children: [
                SizedBox(height: 22.toWidth),
                TitleTextField(
                  controller: viewModel.nicknameController,
                  title: '${tr('input_nickname_title')}',
                  hintText: '${tr('input_nickname_hint')}',
                  onChanged: viewModel.onChangedNickname,
                  onSubmitted: (_) => viewModel.focusoutAll(),
                ),
                TitleTextField(
                  controller: viewModel.emailController,
                  title: '${tr('input_email_title')}',
                  hintText: '${tr('input_email_title')}',
                  onChanged: viewModel.onChangedEmail,
                  onSubmitted: (_) => viewModel.focusoutAll(),
                ),
                TitleTextField(
                  controller: viewModel.phoneController,
                  title: '${tr('input_phone_title')}',
                  hintText: '${tr('input_phone_title')}',
                  onChanged: viewModel.onChangedPhone,
                  onSubmitted: (_) => viewModel.focusoutAll(),
                ),
                const Spacer(),
                Selector<CustomerModifyViewModel, String>(
                  selector: (_, prov) => prov.nickname,
                  builder: (_, nickname, __) {
                    bool isValid = nickname.length > 1;
                    GonLog().e('isValid : $isValid');
                    return GonButton(
                      onPressed: isValid
                          ? () => viewModel.onClickModifyButton(
                              customer: widget.customer)
                          : null,
                      option: GonButtonOption.fill(
                        text: '${tr('modify_btn_title')}',
                        theme: GonButtonFillTheme.lightBlue,
                        style: GonButtonFillStyle.fullRegular,
                      ),
                    );
                  },
                ),
                SizedBox(height: GonStyle.defaultBottomPadding() + 14.toWidth),
              ],
            ),
          ),
        );
      },
    );
  }
}
