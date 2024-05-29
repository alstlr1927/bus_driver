import 'package:bus_counter/common/view/root_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/components/custom_dialog/hobby_dialog.dart';
import '../../common/components/title_text_field/field_controller.dart';
import '../../common/helper/shared_preferences_helper.dart';
import '../../common/provider/profile_provider.dart';
import '../../common/utils/logger.dart';
import '../../manager/model/manager_model.dart';
import '../../manager/view/input_regist_user_info.dart';
import '../repository/login_repository.dart';

class EmailLoginViewModel extends ChangeNotifier {
  State state;

  late FieldController emailController;
  late FieldController pwController;

  String email = '';
  String pw = '';

  bool _isRememberEmail = false;
  bool get isRememberEmail => _isRememberEmail;

  void focusoutAll() {
    emailController.unfocus();
    pwController.unfocus();
  }

  void setRememberEmail(bool flag) {
    _isRememberEmail = flag;
    notifyListeners();
  }

  void validateEmail(String text) async {
    emailController.resetStatus();
    if (text.isEmpty) {
      return;
    }
    String p =
        r'^(([^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]+(\.[^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]+)*)|(“.+“))@(([^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]+\.)+[^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]{2,})$';
    RegExp regExp = RegExp(p);

    if (!regExp.hasMatch(text)) {
      emailController.setErrorText('${tr('input_email_error_text')}');
      emailController.setHasError(true);
      emailController.setIsValid(false);
    } else {
      emailController.setHasError(false);
      emailController.setIsEnable(true);
      emailController.setIsValid(true);
    }
    email = text;
  }

  void validatePassword(String text) async {
    if (text.isEmpty) {
      pwController.resetStatus();
      return;
    }
    String p =
        r'^(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,20}$';
    RegExp regExp = RegExp(p);
    if (!regExp.hasMatch(text)) {
      pwController.setErrorText('${tr('input_pw_error_text')}');
      pwController.setHasError(true);
      pwController.setIsValid(false);
    } else {
      pwController.setHasError(false);
      pwController.setIsValid(true);
      pwController.setIsEnable(true);
    }
    pw = text;
  }

  Future<void> onClickLoginButton() async {
    try {
      GonLog().i(
          'LOGIN APPLY\nEMAIL : ${emailController.status.text}\nPW : ${pwController.status.text}');
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.status.text,
        password: pwController.status.text,
      );

      if (credential.user == null) return;

      if (isRememberEmail) {
        SharedPreferencesHelper().setRememberEmail(emailController.status.text);
      }

      if (credential.user?.emailVerified ?? false) {
        getUserByUid(uid: credential.user!.uid);
      } else {
        await showEmailVerifyDialog(sendEmail: () {
          credential.user?.sendEmailVerification();
        }).then((value) {
          FirebaseAuth.instance.signOut();
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _alertDialog(title: '${tr('email_not_found')}');
      } else if (e.code == 'wrong-password') {
        _alertDialog(title: '${tr('wrong_password_text')}');
      }
    } catch (e, trace) {
      GonLog().e('EMAIL LOGIN ERROR : ${e}');
      GonLog().e('$trace');
    }
  }

  Future<void> _alertDialog({required String title}) async {
    await showDialog(
      context: state.context,
      builder: (context) {
        return GonDialog(
          title: '${tr('app_ko_title')}',
          content: '$title',
          itemList: [
            GonDialogBtnItem(
              title: '${tr('confirm_btn_title')}',
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getUserByUid({required String uid}) async {
    final res = await LoginRepository().getUserByUid(uid: uid);

    if (res != null && res.exists) {
      var data = ManagerModel.fromJson(res.data()!);
      Provider.of<ProfileProvider>(state.context, listen: false)
          .updateProfileInfo(data);
      state.context.goNamed(RootScreen.routeName);
    } else {
      state.context.goNamed(InputRegistUserInfo.routeName);
    }
  }

  Future<void> showEmailVerifyDialog({
    required VoidCallback sendEmail,
  }) async {
    await showDialog(
      context: state.context,
      builder: (context) => GonDialog(
        title: '${tr('app_ko_title')}',
        content: '${tr('not_verified_email_title')}',
        itemList: [
          GonDialogBtnItem(
            title: '${tr('confirm_btn_title')}',
            onPressed: () {
              context.pop();
            },
          ),
          GonDialogBtnItem(
            title: '${tr('retry_send_verify_email')}',
            onPressed: () {
              sendEmail.call();
              context.pop();
            },
          ),
        ],
      ),
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
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  EmailLoginViewModel(this.state) {
    _initData();
  }

  Future<void> _initData() async {
    emailController = FieldController();
    pwController = FieldController();
    String email = await SharedPreferencesHelper().getRememberEmail();
    if (email.isNotEmpty) {
      _isRememberEmail = true;
    }
    emailController.setInitText(email);
    emailController.setIsValid(true);
    emailController.statusStream?.add(emailController.status);
    notifyListeners();
  }
}
