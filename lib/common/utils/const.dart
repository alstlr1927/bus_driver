import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:flutter/material.dart';

class Constants {
  static String appName = 'GonBug';

  // Theme
  static ThemeData theme = ThemeData(
    fontFamily: 'pretendard',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GonStyle.body2(
        color: Colors.black,
        weight: FontWeight.w600,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );

  // Text Styles
  static var defaultTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'pretendard',
    fontWeight: FontWeight.w400,
  );

  static var textFieldHintStyle = defaultTextStyle.copyWith(
    color: const Color(0xFF555555),
  );
  static var textFieldErrorStyle = defaultTextStyle.copyWith(
    color: const Color(0xFF777777),
    fontSize: 12.0,
  );

  static var appBarTitleStyle =
      defaultTextStyle.copyWith(fontWeight: FontWeight.w700);
}
