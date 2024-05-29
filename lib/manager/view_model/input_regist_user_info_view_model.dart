import 'package:bus_counter/common/view/root_screen.dart';
import 'package:bus_counter/manager/repository/manager_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/components/custom_dialog/hobby_dialog.dart';
import '../../common/components/title_text_field/field_controller.dart';
import '../../common/provider/profile_provider.dart';
import '../../login/repository/login_repository.dart';
import '../model/manager_model.dart';

class InputRegistUserInfoViewModel extends ChangeNotifier {
  State state;

  FieldController nicknameController = FieldController();
  String nickname = '';

  bool isLoad = false;

  void focusoutAll() {
    nicknameController.unfocus();
  }

  void setLoad(bool flag) {
    isLoad = flag;
    notifyListeners();
  }

  void validateNickname(String text) async {
    nicknameController.resetStatus();
    if (text.isEmpty) {
      return;
    }

    if (nicknameValidate(text)) {
      nicknameController.setHasError(false);
      nicknameController.setIsEnable(true);
      nicknameController.setIsValid(true);
    } else {
      nicknameController.setErrorText('닉네임 양식에 맞춰라 (2 ~ 16)');
      nicknameController.setHasError(true);
      nicknameController.setIsValid(false);
    }
    nickname = text;
    notifyListeners();
  }

  bool nicknameValidate(String val) {
    return val.length > 1 && val.length < 17;
  }

  Future<void> onClickRegistBtn() async {
    if (isLoad) return;
    setLoad(true);
    await emailUserRegist();
    setLoad(false);
  }

  Future<void> emailUserRegist() async {
    final isExist =
        await ManagerRepository().checkDuplicatedNickname(nickname: nickname);
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final email = FirebaseAuth.instance.currentUser?.email ?? '';

    if (uid.isEmpty || email.isEmpty) {
      return;
    }

    if (isExist) {
      _showDuplicatedDialog();
      return;
    }

    final res = await ManagerRepository().createUserByEmail(
      uid: uid,
      nickname: nickname,
      email: email,
    );

    if (!res) return;

    final response = await LoginRepository().getUserByUid(uid: uid);

    if (response != null && response.exists) {
      var data = ManagerModel.fromJson(response.data()!);
      Provider.of<ProfileProvider>(state.context, listen: false)
          .updateProfileInfo(data);
      state.context.goNamed(RootScreen.routeName);
    } else {
      // server error
    }
  }

  Future _showDuplicatedDialog() async {
    await showDialog(
      context: state.context,
      builder: (context) {
        return GonDialog(
          title: '${tr('app_ko_title')}',
          content: '${tr('duplicated_nickname_dialog_text')}',
          itemList: [
            GonDialogBtnItem(
              title: '${tr('confirm_btn_title')}',
              onPressed: () {
                state.context.pop();
              },
            ),
          ],
        );
      },
    );
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
    super.dispose();
  }

  InputRegistUserInfoViewModel(this.state);
}
