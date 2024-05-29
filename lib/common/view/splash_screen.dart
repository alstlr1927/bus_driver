import 'dart:async';

import 'package:bus_counter/common/utils/images.dart';
import 'package:bus_counter/common/view/root_screen.dart';
import 'package:bus_counter/manager/model/manager_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../login/repository/login_repository.dart';
import '../../login/view/login_landing_screen.dart';
import '../../manager/view/input_regist_user_info.dart';
import '../layout/default_layout.dart';
import '../provider/profile_provider.dart';
import '../utils/logger.dart';

class SplashScreen extends StatefulWidget {
  static String get routeName => 'splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _userLoginStateCheck();
  }

  Future<void> _userLoginStateCheck() async {
    await Future.delayed(const Duration(milliseconds: 1700));
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      goNamed(LoginLandingScreen.routeName);
      GonLog().i('user is null');
    } else {
      if (user.emailVerified) {
        GonLog().i('verified');
        final res = await LoginRepository().getUserByUid(uid: user.uid);
        if (res != null && res.exists) {
          var data = ManagerModel.fromJson(res.data()!);
          Provider.of<ProfileProvider>(context, listen: false)
              .updateProfileInfo(data);
          goNamed(RootScreen.routeName);
        } else {
          goNamed(InputRegistUserInfo.routeName);
        }
      } else {
        GonLog().i('not verified');
        FirebaseAuth.instance.signOut();
        goNamed(LoginLandingScreen.routeName);
      }
    }
  }

  void goNamed(String routeName) {
    if (mounted) {
      context.goNamed(routeName);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.black,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
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
      ),
    );
  }
}
