import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/components/custom_button/custom_button.dart';
import '../../common/components/title_text_field/title_text_field.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/validator.dart';
import '../view_model/email_regist_view_model.dart';

class EmailRegistScreen extends StatefulWidget {
  static String get routeName => 'email_regist';

  const EmailRegistScreen({super.key});

  @override
  State<EmailRegistScreen> createState() => _EmailRegistScreenState();
}

class _EmailRegistScreenState extends State<EmailRegistScreen> {
  late EmailRegistViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = EmailRegistViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailRegistViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('signup_title')}',
          onPressed: () => viewModel.focusoutAll(),
          resizeToAvoidBottomInset: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Column(
              children: [
                SizedBox(height: 32.toWidth),
                const _EmailPwInputArea(),
                SizedBox(height: 25.toWidth),
                const _EmailRegistButtonWrapper(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmailPwInputArea extends StatelessWidget {
  const _EmailPwInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailRegistViewModel viewModel =
        Provider.of<EmailRegistViewModel>(context, listen: false);
    return Column(
      children: [
        TitleTextField(
          controller: viewModel.emailController,
          title: '${tr('input_email_title')}',
          hintText: '${tr('input_email_title')}',
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.deny(Validator().kWhiteSpaceRegex)
          ],
          autofillHints: const [AutofillHints.email],
          onChanged: viewModel.validateEmail,
          onSubmitted: (value) => viewModel.focusoutAll(),
        ),
        SizedBox(height: 6.toWidth),
        TitleTextField(
          controller: viewModel.pwController,
          title: '${tr('input_pw_title')}',
          hintText: '${tr('input_pw_title')}',
          isObscure: true,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.deny(Validator().kWhiteSpaceRegex)
          ],
          autofillHints: const [AutofillHints.password],
          onChanged: viewModel.validatePassword,
          onSubmitted: (value) => viewModel.focusoutAll(),
        ),
        SizedBox(height: 6.toWidth),
        TitleTextField(
          controller: viewModel.checkController,
          title: '${tr('input_pw_check_title')}',
          hintText: '${tr('input_pw_check_title')}',
          isObscure: true,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.deny(Validator().kWhiteSpaceRegex)
          ],
          autofillHints: const [AutofillHints.password],
          onChanged: viewModel.validateCheckPassword,
          onSubmitted: (value) => viewModel.focusoutAll(),
        ),
      ],
    );
  }
}

class _EmailRegistButtonWrapper extends StatelessWidget {
  const _EmailRegistButtonWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailRegistViewModel viewModel =
        Provider.of<EmailRegistViewModel>(context, listen: false);
    return StreamBuilder<bool>(
      initialData: false,
      stream: Rx.combineLatest3(
          viewModel.emailController.statusStream!,
          viewModel.pwController.statusStream!,
          viewModel.checkController.statusStream!,
          (a, b, c) => (a.isValid && b.isValid && c.isValid)),
      builder: (context, snapshot) {
        bool isChecked = snapshot.data!;
        return GonButton(
          onPressed: isChecked ? viewModel.onClickRegistBtn : null,
          option: GonButtonOption.fill(
            text: '${tr('next_btn_title')}',
            theme: GonButtonFillTheme.magenta,
            style: GonButtonFillStyle.fullRegular,
          ),
        );
      },
    );
  }
}
