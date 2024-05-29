import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/components/custom_button/custom_button.dart';
import '../../common/components/title_text_field/title_text_field.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/gon_style.dart';
import '../../common/utils/validator.dart';
import '../../login/view/login_landing_screen.dart';
import '../view_model/input_regist_user_info_view_model.dart';

class InputRegistUserInfo extends StatefulWidget {
  static String get routeName => 'input_user_info';

  const InputRegistUserInfo({super.key});

  @override
  State<InputRegistUserInfo> createState() => _InputRegistUserInfoState();
}

class _InputRegistUserInfoState extends State<InputRegistUserInfo> {
  late InputRegistUserInfoViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = InputRegistUserInfoViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InputRegistUserInfoViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '회원가입',
          leading: _leading(),
          onPressed: () => viewModel.focusoutAll(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _InputNicknameArea(),
                // const _SelectGenderArea(),
                Spacer(),
                const _RegistButtonArea(),
                SizedBox(height: GonStyle.defaultBottomPadding() + 14.toWidth),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _leading() {
    return CupertinoButton(
      child: Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
      ),
      onPressed: () {
        FirebaseAuth.instance.signOut();
        context.goNamed(LoginLandingScreen.routeName);
      },
    );
  }
}

class _InputNicknameArea extends StatelessWidget {
  const _InputNicknameArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputRegistUserInfoViewModel viewModel =
        Provider.of<InputRegistUserInfoViewModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.toWidth),
        Text(
          '${tr('input_info_nickname_title')}',
          style: GonStyle.body1(weight: FontWeight.w500),
        ),
        SizedBox(height: 16.toWidth),
        TitleTextField(
          controller: viewModel.nicknameController,
          title: '${tr('nickname_title')}',
          hintText: '${tr('nickname_title')}',
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.deny(Validator().kWhiteSpaceRegex)
          ],
          autofillHints: const [AutofillHints.nickname],
          maxLength: 16,
          onChanged: viewModel.validateNickname,
          onSubmitted: (val) => viewModel.focusoutAll(),
        ),
      ],
    );
  }
}

class _RegistButtonArea extends StatelessWidget {
  const _RegistButtonArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputRegistUserInfoViewModel viewModel =
        Provider.of<InputRegistUserInfoViewModel>(context, listen: false);
    return Selector<InputRegistUserInfoViewModel, String>(
      selector: (_, prov) => prov.nickname,
      builder: (_, nickname, __) {
        final isValid = viewModel.nicknameValidate(nickname);
        return GonButton(
          onPressed: isValid ? viewModel.onClickRegistBtn : null,
          option: GonButtonOption.fill(
            text: '${tr('signup_btn_title')}',
            theme: GonButtonFillTheme.magenta,
            style: GonButtonFillStyle.fullRegular,
          ),
        );
      },
    );
  }
}
