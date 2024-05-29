import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/custom_dialog/hobby_dialog.dart';
import '../../common/components/title_text_field/field_controller.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/validator.dart';
import '../view/email_login_screen.dart';

class EmailRegistViewModel extends ChangeNotifier {
  State state;

  FieldController emailController = FieldController();
  FieldController pwController = FieldController();
  FieldController checkController = FieldController();

  void focusoutAll() {
    emailController.unfocus();
    pwController.unfocus();
    checkController.unfocus();
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
  }

  void validatePassword(String text) async {
    if (text.isEmpty) {
      pwController.resetStatus();
      return;
    }
    if (!Validator.validPasswordPattern(text)) {
      pwController.setErrorText('${tr('input_pw_error_text')}');
      pwController.setHasError(true);
      pwController.setIsValid(false);
    } else {
      pwController.setHasError(false);
      pwController.setIsValid(true);
      pwController.setIsEnable(true);
    }

    if (text != checkController.getStatus.text) {
      checkController.setErrorText('${tr('input_check_pw_error_text')}');
      checkController.setHasError(true);
      checkController.setIsValid(false);
    } else {
      checkController.setHasError(false);
      checkController.setIsValid(true);
      checkController.setIsEnable(true);
    }
  }

  void validateCheckPassword(String text) async {
    if (text.isEmpty) {
      checkController.resetStatus();
      return;
    }
    if (text != pwController.getStatus.text) {
      checkController.setErrorText('${tr('input_check_pw_error_text')}');
      checkController.setHasError(true);
      checkController.setIsValid(false);
    } else {
      checkController.setHasError(false);
      checkController.setIsValid(true);
      checkController.setIsEnable(true);
    }
  }

  Future<void> onClickRegistBtn() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.status.text,
        password: pwController.status.text,
      );
      await FirebaseAuth.instance.setLanguageCode('kr');
      await credential.user?.sendEmailVerification();
      FirebaseAuth.instance.signOut();
      await _alertDialog(title: '${tr('verify_email_dialog_content')}');
      state.context.goNamed(EmailLoginScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _alertDialog(title: '${tr('already_exist_email_text')}');
      }
    } catch (e) {
      GonLog().e('EMAIL REGIST ERROR : $e');
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
    checkController.dispose();
    super.dispose();
  }

  EmailRegistViewModel(this.state);
}
