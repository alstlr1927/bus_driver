import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:flutter/material.dart';

import '../../common/components/base_button/base_button.dart';
import '../../common/utils/gon_style.dart';

class LoginFillButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final ImageProvider? image;
  final Color backgroundColor;
  final Color textColor;

  const LoginFillButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.image,
    this.backgroundColor = GonStyle.black,
    this.textColor = GonStyle.black,
  });

  @override
  Widget build(BuildContext context) {
    var border;
    if (backgroundColor == GonStyle.white) {
      border = Border.all(width: .5, color: GonStyle.gray070);
    }
    return BaseButton(
      onPressed: onPressed,
      child: Container(
        height: 48.toWidth,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
            border: border),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image(
                image: image!,
                width: 16.toWidth,
              ),
            SizedBox(width: 8.toWidth),
            Text(
              title,
              style: GonStyle.body2(
                color: textColor,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
