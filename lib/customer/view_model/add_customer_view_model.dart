import 'package:bus_counter/common/components/title_text_field/field_controller.dart';
import 'package:bus_counter/customer/repository/customer_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/custom_dialog/gon_dialog_land.dart';

class AddCustomerViewModel extends ChangeNotifier {
  State state;

  String nickname = '';
  String email = '';
  String phone = '';

  FieldController nicknameController = FieldController();
  FieldController emailController = FieldController();
  FieldController phoneController = FieldController();

  bool isLoad = false;

  void unfocusAllOut() {
    nicknameController.unfocus();
    emailController.unfocus();
    phoneController.unfocus();
  }

  void nicknameChanged(String val) {
    nickname = val.trim();
    notifyListeners();
  }

  void emailChanged(String val) {
    email = val.trim();
    notifyListeners();
  }

  void phoneChanged(String val) {
    phone = val.trim();
    notifyListeners();
  }

  Future<void> onClickRegistButton() async {
    bool isValid =
        await CustomerRepository().checkDuplicateNickname(nickname: nickname);
    if (!isValid) {
      _alertDialog(
        title: '${tr('duplicated_nickname_dialog_text')}',
        confirm: () => state.context.pop(),
      );
      return;
    }
    if (isLoad) return;
    isLoad = true;
    await CustomerRepository().createCustomer(
      nickname: nickname,
      email: email,
      phone: phone,
    );
    isLoad = false;
    state.context.pop();
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

  AddCustomerViewModel(this.state);

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
