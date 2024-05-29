import 'package:bus_counter/common/components/title_text_field/field_controller.dart';
import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/customer/repository/customer_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/custom_dialog/gon_dialog_land.dart';
import '../model/customer_model.dart';
import '../view/customer_modify_screen.dart';

class CustomerModifyViewModel extends ChangeNotifier {
  State<CustomerModifyScreen> state;

  late FieldController nicknameController;
  late FieldController emailController;
  late FieldController phoneController;

  String nickname = '';
  String email = '';
  String phone = '';

  bool isLoad = false;

  void focusoutAll() {
    nicknameController.unfocus();
    emailController.unfocus();
    phoneController.unfocus();
  }

  void onChangedNickname(String val) {
    nickname = val.trim();
    notifyListeners();
  }

  void onChangedEmail(String val) {
    email = val.trim();
    notifyListeners();
  }

  void onChangedPhone(String val) {
    phone = val.trim();
    notifyListeners();
  }

  Future<void> onClickModifyButton({required CustomerModel customer}) async {
    try {
      if (customer.nickname != nickname) {
        bool isValid = await CustomerRepository()
            .checkDuplicateNickname(nickname: nickname);
        if (!isValid) {
          _alertDialog(
            title: '${tr('duplicated_nickname_dialog_text')}',
            confirm: () => state.context.pop(),
          );
          return;
        }
      }

      if (isLoad) return;
      isLoad = true;
      await CustomerRepository().updateCustomer(
        customerUid: customer.uid,
        nickname: nickname,
        email: email,
        phone: phone,
      );
      isLoad = false;
      CustomerModel copyCustomer = state.widget.customer.copyWith(
        email: email,
        nickname: nickname,
        phone: phone,
      );
      state.context.pop(copyCustomer);
    } catch (e, trace) {
      isLoad = false;
      GonLog().e('updateCustomer error : $e');
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
    nicknameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  CustomerModifyViewModel(this.state) {
    _initData();
  }

  void _initData() {
    nickname = state.widget.customer.nickname;
    email = state.widget.customer.email;
    phone = state.widget.customer.phone;

    nicknameController = FieldController(initText: nickname);
    emailController = FieldController(initText: email);
    phoneController = FieldController(initText: phone);

    notifyListeners();
  }

  Future<void> _alertDialog({
    required String title,
    VoidCallback? confirm,
  }) async {
    await showDialog(
      context: state.context,
      builder: (context) {
        return GonDialogLand(
          title: '${tr('app_ko_title')}',
          content: '$title',
          itemList: [
            GonDialogBtnItem(
              title: '${tr('confirm_btn_title')}',
              onPressed: () {
                confirm?.call();
              },
            ),
          ],
        );
      },
    );
  }
}
