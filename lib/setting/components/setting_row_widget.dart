import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/components/base_button/base_button.dart';

class SettingRowWidget extends StatelessWidget {
  final String? leading;
  final Widget? action;
  final String? icon;
  final Function()? onTap;

  const SettingRowWidget(
      {super.key, this.leading, this.action, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onTap,
      child: Container(
        height: 48.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Row(
          children: [
            if (icon != null) ...{
              Image.asset(
                icon!,
                width: 24.toWidth,
                height: 24.toWidth,
              ),
              SizedBox(width: 15.toWidth),
            },
            Text(
              tr(leading ?? ""),
              style: GonStyle.caption(
                weight: FontWeight.bold,
                color: GonStyle.gray080,
              ),
            ),
            const Spacer(),
            action ??
                Image.asset(
                  rightArrow,
                  height: 14.toWidth,
                  width: 14.toWidth,
                ),
          ],
        ),
      ),
    );
  }
}
