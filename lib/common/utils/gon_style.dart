import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GonStyle {
  static const defaultDesignSize = Size(375, 667);
  static const tabletDesignSize = Size(700, 1232);
  static Size applyDesignSize = const Size(375, 667);

  static get sizeFactor => applyDesignSize.width / defaultDesignSize.width;

  static List<Shadow> text_shadow() {
    return [
      Shadow(
        color: Colors.black.withOpacity(.7),
        offset: Offset(0, 0),
        blurRadius: 4,
      ),
    ];
  }

  static List<BoxShadow> elevation_01dp() {
    return [
      const BoxShadow(
          color: Color(0x14000000),
          offset: Offset(0, 3),
          blurRadius: 3,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_03dp() {
    return [
      const BoxShadow(
          color: Color(0x14000000),
          offset: Offset(0, 3),
          blurRadius: 8,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x08000000),
          offset: Offset(0, 2),
          blurRadius: 5,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_04dp() {
    return [
      const BoxShadow(
          color: Color(0x1a000000),
          offset: Offset(0, 6),
          blurRadius: 8,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x0d000000),
          offset: Offset(0, 1),
          blurRadius: 5,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_06dp() {
    return [
      const BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: -1),
      const BoxShadow(
          color: Color(0x1f000000),
          offset: Offset(0, 1),
          blurRadius: 18,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x24000000),
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_8dp() {
    return [
      const BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: -1),
      const BoxShadow(
          color: Color(0x1f000000),
          offset: Offset(0, 1),
          blurRadius: 18,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x24000000),
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_24dp() {
    return [
      const BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 11),
          blurRadius: 15,
          spreadRadius: -7),
      const BoxShadow(
          color: Color(0x1f000000),
          offset: Offset(0, 9),
          blurRadius: 46,
          spreadRadius: 8),
      const BoxShadow(
          color: Color(0x24000000),
          offset: Offset(0, 24),
          blurRadius: 38,
          spreadRadius: 3)
    ];
  }

  static TextStyle title({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(28),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 39 / 28,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle eventTitle({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(40),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle big({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(56),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h1({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(48),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h2({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(32),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 46 / 32,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h3({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(24),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 34 / 24,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h4({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(20),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 27 / 20,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h5({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(18),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 25 / 18,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle body1({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(16),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 22 / 16,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle body2({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(14),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 18 / 14,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle caption({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(12),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 16 / 12,
        letterSpacing: 0,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle overline({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(10),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 13 / 10,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle largeMini({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(8),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 10 / 8,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle mini({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(6),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 8 / 6,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle custom({
    Color? color,
    FontWeight? weight,
    required double fontSize,
  }) {
    return TextStyle(
        fontSize: fontSize,
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle poster({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(28),
        color: color ?? GonStyle.black,
        fontWeight: weight ?? FontWeight.normal,
        height: 1.1,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static double defaultBottomPadding() {
    if (ScreenUtil().bottomBarHeight == 0) {
      return 16.0;
    } else {
      return ScreenUtil().bottomBarHeight;
    }
  }

  static double bottomActionsHeight = 44.toWidth + defaultBottomPadding();

  static double safeAreaPadding() {
    if (ScreenUtil().bottomBarHeight == 0) {
      return 0.0;
    } else {
      return ScreenUtil().bottomBarHeight;
    }
  }

  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);

  static const primary010 = Color(0xFFFFF9FA);
  static const primary020 = Color(0xFFFFEDEF);
  static const primary030 = Color(0xFFFFCDD7);
  static const primary040 = Color(0xFFFF7E8A);
  static const primary050 = Color(0xFFFF475D);
  static const primary060 = Color(0xFFFF334B);
  static const primary070 = Color(0xFFF31237);
  static const primary080 = Color(0xFFD80039);
  static const primary090 = Color(0xFFA8002C);

  static const gray010 = Color(0xFFFCFCFC);
  static const gray020 = Color(0xFFFAFAFA);
  static const gray030 = Color(0xFFF5F5F5);
  static const gray040 = Color(0xFFEEEEEE);
  static const gray050 = Color(0xFFE0E0E0);
  static const gray060 = Color(0xFF9E9E9E);
  static const gray070 = Color(0xFF616161);
  static const gray080 = Color(0xFF424242);
  static const gray090 = Color(0xFF212121);

  static const korean = Color(0xFFF67949);
  static const english = Color(0xFF7684FF);

  static const subGreen = Color(0xFF4FCB6B);
  static const subYellow = Color(0xFFF8C030);
  static const subYellow24 = Color(0xFFFDF0CD);
  static const subYellow40 = Color(0xFFFCE6AC);
  static const subBlue = Color(0xFF1873FF);
  static const subBlue10 = Color(0xFFE8F1FF);

  static const background = Color(0xFFF0F3F8);

  static const negationRed = Color(0xFFC7000D);
  static const red = Color(0xFFFF5F5F);
  static const sky = Color(0xFF51B5FF);
  static const yellow = Color(0xFFFFAF16);
  static const green = Color(0xFF60E269);
  static const violet = Color(0xFFD166F8);
  static const orange = Color(0xFFF67949);
  static const blue = Color(0xFF7684FF);
  static const mint = Color(0xFF00DCCA);
  static const brown = Color(0xFFB6693C);
  static const gray = Color(0xFF999999);
  static const navy = Color(0xFF1E2C5F);
  static const deepNavy = Color(0xFF0D1878);

  static const thanksGivingPrimary = Color(0xFFF0D8B5);
  static const thanksGivingSecondary = Color(0xFFA86C55);

  /* ---------------------- old styles ----------------------*/

  @deprecated
  static const old_blue005 = const Color(0xffF6FCFE);
  @deprecated
  static const old_blue010 = const Color(0xffe1f5fc);
  @deprecated
  static const old_blue020 = const Color(0xffB3E6F6);
  @deprecated
  static const old_blue030 = const Color(0xff81D6F1);
  @deprecated
  static const old_blue040 = const Color(0xff50c5ec);
  @deprecated
  static const old_blue050 = const Color(0xff27b9ea);
  @deprecated
  static const old_blue060 = const Color(0xff00ACE9);
  @deprecated
  static const old_blue070 = const Color(0xff009edb);
  @deprecated
  static const old_blue080 = const Color(0xff008CC8);
  @deprecated
  static const old_blue090 = const Color(0xff007bb5);
  @deprecated
  static const old_blue100 = const Color(0xff005b95);

  @deprecated
  static const old_gray005 = const Color(0xfffcfcfc);
  @deprecated
  static const old_gray010 = const Color(0xfffafafa);
  @deprecated
  static const old_gray020 = const Color(0xfff5f5f5);
  @deprecated
  static const old_gray030 = const Color(0xffeeeeee);
  @deprecated
  static const old_gray040 = const Color(0xffe0e0e0);
  @deprecated
  static const old_gray050 = const Color(0xffbdbdbd);
  @deprecated
  static const old_gray060 = const Color(0xff9e9e9e);
  @deprecated
  static const old_gray070 = const Color(0xff757575);
  @deprecated
  static const old_gray080 = const Color(0xff616161);
  @deprecated
  static const old_gray090 = const Color(0xff424242);
  @deprecated
  static const old_gray100 = const Color(0xff212121);

  @deprecated
  static const old_coral005 = const Color(0xfffff9fa);
  @deprecated
  static const old_coral010 = const Color(0xffffebee);
  @deprecated
  static const old_coral020 = const Color(0xffffccd1);
  @deprecated
  static const old_coral030 = const Color(0xfffa9797);
  @deprecated
  static const old_coral040 = const Color(0xfff46d6d);
  @deprecated
  static const old_coral045 = const Color(0xffFF5F5F);
  @deprecated
  static const old_coral050 = const Color(0xffff4747);
  @deprecated
  static const old_coral055 = const Color(0xffEE4A4A);
  @deprecated
  static const old_coral060 = const Color(0xffff2f27);
  @deprecated
  static const old_coral070 = const Color(0xfff62229);
  @deprecated
  static const old_coral080 = const Color(0xffe41023);
  @deprecated
  static const old_coral090 = const Color(0xffd7001b);
  @deprecated
  static const old_coral100 = const Color(0xffc7000d);

  @deprecated
  static const old_violet005 = const Color(0xfff9f7ff);
  @deprecated
  static const old_violet006 = const Color(0xfff4f0ff);
  @deprecated
  static const old_violet010 = const Color(0xffece5ff);
  @deprecated
  static const old_violet020 = const Color(0xffccc0fd);
  @deprecated
  static const old_violet030 = const Color(0xffa796fd);
  @deprecated
  static const old_violet040 = const Color(0xFF7C6BFF);
  @deprecated
  static const old_violet050 = const Color(0xFF514AFF);
  @deprecated
  static const old_violet060 = const Color(0xff082bf3);
  @deprecated
  static const old_violet070 = const Color(0xff0028ed);
  @deprecated
  static const old_violet080 = const Color(0xff0021e4);
  @deprecated
  static const old_violet090 = const Color(0xff001ddc);
  @deprecated
  static const old_violet100 = const Color(0xff0014cd);

  @deprecated
  static const old_brown010 = const Color(0xffF0EDE6);
  @deprecated
  static const old_brown020 = const Color(0xffDFD8C8);
  @deprecated
  static const old_brown030 = const Color(0xffCFC6B0);

  @deprecated
  static const old_quizEventColor = const Color(0xffD0FFF2);
  @deprecated
  static const old_quizEventDeepColor = const Color(0xff00C0A3);
  @deprecated
  static const old_quizEventUnderlineColor = const Color(0xff7BFFDB);

  @deprecated
  static const List<Color> old_gradient45 = const [
    Color(0xffff923c),
    Color(0xffff4747)
  ];

  @deprecated
  static const old_grayscaleF8 = const Color(0xfff8f8f8);
  @deprecated
  static const old_grayscaleEE = const Color(0xffeeeeee);
  @deprecated
  static const old_grayscaleDD = const Color(0xffdddddd);
  @deprecated
  static const old_grayscaleCC = const Color(0xffcccccc);
  @deprecated
  static const old_grayscale99 = const Color(0xff999999);
  @deprecated
  static const old_grayscale66 = const Color(0xff666666);
  @deprecated
  static const old_grayscale33 = const Color(0xff333333);
  @deprecated
  static const old_grayscaleWhite = const Color(0xffffffff);
  @deprecated
  static const old_grayscaleBlack = const Color(0xff000000);
  @deprecated
  static const old_primaryBasic2 = const Color(0xffefedff);
  @deprecated
  static const old_primaryBasic = const Color(0xffff4747);
  @deprecated
  static const old_errorColor01 = const Color(0xfff62229);
  @deprecated
  static const old_errorColor02 = const Color(0xffe21b11);
  @deprecated
  static const old_positiveColor = const Color(0xff514aff);
}
