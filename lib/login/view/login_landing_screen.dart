import 'dart:io';

import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/images.dart';
import 'package:bus_counter/login/view/email_login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/components/base_button/base_button.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/gon_style.dart';
import '../components/login_fill_button.dart';
import '../view_model/login_landing_view_model.dart';
import 'email_regist_screen.dart';

class LoginLandingScreen extends StatefulWidget {
  static String get routeName => 'login_landing';

  const LoginLandingScreen({super.key});

  @override
  State<LoginLandingScreen> createState() => _LoginLandingScreenState();
}

class _LoginLandingScreenState extends State<LoginLandingScreen> {
  late LoginLandingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LoginLandingViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginLandingViewModel>.value(
      value: viewModel,
      builder: (ctx, _) {
        return DefaultLayout(
          backgroundColor: GonStyle.white,
          child: Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    splashImage,
                    width: ScreenUtil().screenWidth,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                      child: Container(
                    color: Color(0xff1c070a),
                  )),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(ctx).padding.top + 60.toWidth),
                  Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenWidth,
                  ),
                  Spacer(),
                  _BottomLoginButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomLoginButton extends StatelessWidget {
  const _BottomLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.toWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoginFillButton(
            onPressed: () async {
              context.pushNamed(EmailLoginScreen.routeName);
            },
            title: '${tr('email_login_btn_text')}',
            backgroundColor: GonStyle.white,
          ),
          SizedBox(height: 12.toWidth),
          LoginFillButton(
            onPressed: () {
              context.pushNamed(EmailRegistScreen.routeName);
            },
            title: '${tr('email_regist_btn_text')}',
            textColor: GonStyle.white,
            backgroundColor: GonStyle.english,
          ),
          SizedBox(height: GonStyle.defaultBottomPadding() + 20.toWidth),
        ],
      ),
    );
  }
}
