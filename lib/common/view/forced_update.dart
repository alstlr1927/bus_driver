import 'dart:io';

import 'package:bus_counter/common/repository/gon_repository.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../layout/default_layout.dart';
import '../utils/images.dart';

class ForcedUpdate extends StatefulWidget {
  final String curVer;
  const ForcedUpdate({
    super.key,
    required this.curVer,
  });

  @override
  State<ForcedUpdate> createState() => _ForcedUpdateState();
}

class _ForcedUpdateState extends State<ForcedUpdate> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GonRepository().getLatestVersion().then((String latestVersion) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _ShownyForceUpdateDialog(
            message: '업데이트 알림',
            subMessage: '새로운 버전이 나왔어요!\n개발자에게 새로운 버전을 달라고 요청하세요',
            curVer: widget.curVer,
            latestVer: latestVersion,
            primaryLabel: '확인',
            primaryAction: () {
              SystemNavigator.pop();
            },
          ),
        );
      });
      _init();
    });
  }

  Future _init() async {}

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

class _ShownyForceUpdateDialog extends StatelessWidget {
  const _ShownyForceUpdateDialog({
    super.key,
    required this.message,
    required this.subMessage,
    required this.curVer,
    required this.latestVer,
    required this.primaryLabel,
    this.primaryAction,
  });

  final String message;
  final String subMessage;
  final String curVer;
  final String latestVer;
  final String primaryLabel;
  final Function()? primaryAction;

  Widget actionButton(
    BuildContext context, {
    required String label,
    required Function() onPressed,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        color: Colors.transparent,
        height: 48.0,
        child: Center(
          child: Text(
            label,
            style: GonStyle.body2(color: GonStyle.primary050),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 310.toWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    message,
                    style: GonStyle.body2(weight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    subMessage,
                    style: GonStyle.body2(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    '현재 버전 : v$curVer',
                    style: GonStyle.caption(
                      color: const Color(0xffa6a6a6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '업데이트 버전 : v$latestVer',
                    style: GonStyle.caption(
                      color: const Color(0xffa6a6a6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Container(
            //   color: const Color(0xFF999999),
            //   width: 310.0,
            //   height: 1.0,
            // ),
            const Divider(height: 1, thickness: 1, color: Color(0xFFDDDDDD)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: actionButton(
                    context,
                    label: primaryLabel,
                    onPressed: () {
                      if (primaryAction != null) {
                        primaryAction!();
                      }

                      debugPrint('DEBUG: tab $primaryLabel button');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
