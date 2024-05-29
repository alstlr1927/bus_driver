import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/components/base_button/base_button.dart';
import '../../common/components/custom_button/custom_button.dart';
import '../../common/components/title_text_field/title_text_field.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/gon_style.dart';
import '../../common/utils/validator.dart';
import '../components/login_fill_button.dart';
import '../view_model/email_login_view_model.dart';

class EmailLoginScreen extends StatefulWidget {
  static String get routeName => 'email_login';
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  late EmailLoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = EmailLoginViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailLoginViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('login_text')}',
          onPressed: viewModel.focusoutAll,
          resizeToAvoidBottomInset: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Column(
              children: [
                SizedBox(height: 32.toWidth),
                const _EmailPwInputWrapper(),
                SizedBox(height: 25.toWidth),
                const _EmailLoginButtonWrapper(),
                const Spacer(),
                // const _SocialLoginButtonWrapper(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmailPwInputWrapper extends StatelessWidget {
  const _EmailPwInputWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailLoginViewModel viewModel =
        Provider.of<EmailLoginViewModel>(context, listen: false);
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
        SizedBox(height: 12.toWidth),
        Selector<EmailLoginViewModel, bool>(
          selector: (_, prov) => prov.isRememberEmail,
          builder: (_, isRemember, __) {
            return GestureDetector(
              onTap: () => viewModel.setRememberEmail(!isRemember),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.all(2.toWidth),
                    width: 24.toWidth,
                    height: 24.toWidth,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          isRemember ? Colors.transparent : GonStyle.gray050,
                          BlendMode.srcATop),
                      child: Image.asset(checkCircle),
                    ),
                  ),
                  SizedBox(width: 4.toWidth),
                  Text(
                    '${tr('remember_email_btn')}',
                    style: GonStyle.body2(
                      color: GonStyle.gray080,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _EmailLoginButtonWrapper extends StatelessWidget {
  const _EmailLoginButtonWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailLoginViewModel viewModel =
        Provider.of<EmailLoginViewModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: Rx.combineLatest2(
          viewModel.emailController.statusStream!,
          viewModel.pwController.statusStream!,
          (a, b) => (a.isValid && b.isValid)),
      builder: (context, snapshot) {
        bool isChecked = snapshot.data!;
        return GonButton(
          onPressed: isChecked ? viewModel.onClickLoginButton : null,
          option: GonButtonOption.fill(
            text: '${tr('login_text')}',
            theme: GonButtonFillTheme.magenta,
            style: GonButtonFillStyle.fullRegular,
          ),
        );
      },
    );
  }
}
