import 'package:bus_counter/common/components/custom_button/custom_button.dart';
import 'package:bus_counter/common/components/title_text_field/title_text_field.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/customer/view_model/add_customer_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddCustomerScreen extends StatefulWidget {
  static String get routeName => 'add_customer';
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  late AddCustomerViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = AddCustomerViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddCustomerViewModel>.value(
        value: viewModel,
        builder: (context, _) {
          return DefaultLayout(
            onPressed: viewModel.unfocusAllOut,
            title: '${tr('add_customer_title')}',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.toWidth),
                  TitleTextField(
                    title: '${tr('input_nickname_title')}',
                    hintText: '${tr('input_nickname_hint')}',
                    controller: viewModel.nicknameController,
                    onChanged: viewModel.nicknameChanged,
                    onSubmitted: (val) => viewModel.unfocusAllOut(),
                  ),
                  SizedBox(height: 10.toWidth),
                  TitleTextField(
                    title: '${tr('input_email_title')}',
                    hintText: '${tr('input_email_title')}',
                    controller: viewModel.emailController,
                    onChanged: viewModel.emailChanged,
                    onSubmitted: (val) => viewModel.unfocusAllOut(),
                  ),
                  SizedBox(height: 10.toWidth),
                  TitleTextField(
                    title: '${tr('input_phone_title')}',
                    hintText: '${tr('input_phone_title')}',
                    controller: viewModel.phoneController,
                    onChanged: viewModel.phoneChanged,
                    onSubmitted: (val) => viewModel.unfocusAllOut(),
                  ),
                  const Spacer(),
                  Selector<AddCustomerViewModel, String>(
                      selector: (_, prov) => prov.nickname,
                      builder: (_, nickname, __) {
                        final isReady = nickname.isNotEmpty;
                        return GonButton(
                          onPressed:
                              isReady ? viewModel.onClickRegistButton : null,
                          option: GonButtonOption.fill(
                            text: '${tr('regist_btn_title')}',
                            theme: GonButtonFillTheme.lightBlue,
                            style: GonButtonFillStyle.fullRegular,
                          ),
                        );
                      }),
                  SizedBox(
                    height: GonStyle.defaultBottomPadding() + 14.toWidth,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
