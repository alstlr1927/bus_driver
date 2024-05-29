part of gon_button;

abstract class GonButtonStyle {
  GonButtonStyle();
}

abstract class GonButtonTheme {
  GonButtonTheme();
}

/* STYLE===================================================*/

class GonButtonFillStyle extends GonButtonStyle {
  final double height;
  final double? minWidth;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double borderRadius;

  static GonButtonFillStyle get fullLarge => GonButtonFillStyle(
        height: 56.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 18),
        borderRadius: 4,
        textStyle: GonStyle.body1(weight: FontWeight.w600),
      );

  static GonButtonFillStyle get large => GonButtonFillStyle(
        height: 56.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 18),
        minWidth: 88.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.body1(weight: FontWeight.w600),
      );

  static GonButtonFillStyle get xsmall => GonButtonFillStyle(
        height: 28.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 8),
        minWidth: 73.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.caption(weight: FontWeight.w600),
      );

  static GonButtonFillStyle get small => GonButtonFillStyle(
        height: 36.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 16),
        minWidth: 52.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.body2(weight: FontWeight.w600),
      );

  static GonButtonFillStyle get fullSmall => GonButtonFillStyle(
        height: 36.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 4,
        textStyle: GonStyle.body2(weight: FontWeight.w600),
      );

  static GonButtonFillStyle get regular => GonButtonFillStyle(
        height: 48.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 16),
        minWidth: 88.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.body1(weight: FontWeight.w600),
      );

  static GonButtonFillStyle get fullRegular => GonButtonFillStyle(
        height: 48.toWidth,
        padding: EdgeInsets.zero,
        borderRadius: 4,
        textStyle: GonStyle.body1(weight: FontWeight.w600),
      );

  GonButtonFillStyle({
    required this.height,
    this.minWidth,
    required this.padding,
    required this.textStyle,
    required this.borderRadius,
  });

  GonButtonFillStyle copyWith({
    double? height,
    double? minWidth,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? borderRadius,
  }) {
    return GonButtonFillStyle(
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

class GonButtonLineStyle extends GonButtonStyle {
  final double height;
  final double? minWidth;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double borderRadius;

  static GonButtonLineStyle get large => GonButtonLineStyle(
        height: 56.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 18),
        minWidth: 88.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.body1(weight: FontWeight.w600),
      );

  static GonButtonLineStyle get regular => GonButtonLineStyle(
        height: 48.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 16),
        minWidth: 88.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.body1(weight: FontWeight.w600),
      );

  static GonButtonLineStyle get xsmall => GonButtonLineStyle(
        height: 28.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 8),
        minWidth: 73.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.caption(weight: FontWeight.w600),
      );

  static GonButtonLineStyle get small => GonButtonLineStyle(
        height: 36.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 16),
        minWidth: 52.toWidth,
        borderRadius: 4,
        textStyle: GonStyle.body2(weight: FontWeight.w600),
      );

  static GonButtonLineStyle get fullSmall => GonButtonLineStyle(
        height: 36.toWidth,
        padding: EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 4,
        textStyle: GonStyle.body2(weight: FontWeight.w600),
      );

  static GonButtonLineStyle get fullRegular => GonButtonLineStyle(
        height: 48.toWidth,
        padding: EdgeInsets.zero,
        borderRadius: 4,
        textStyle: GonStyle.body1(weight: FontWeight.w600),
      );

  GonButtonLineStyle(
      {required this.height,
      this.minWidth,
      required this.padding,
      required this.textStyle,
      required this.borderRadius});

  GonButtonLineStyle copyWith({
    double? height,
    double? minWidth,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? borderRadius,
  }) {
    return GonButtonLineStyle(
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

class GonButtonIconStyle extends GonButtonStyle {
  double size;

  static GonButtonIconStyle get small => GonButtonIconStyle(
        size: 16.toWidth,
      );

  static GonButtonIconStyle get regular => GonButtonIconStyle(
        size: 24.toWidth,
      );

  GonButtonIconStyle({required this.size});
}

class GonButtonTextStyle extends GonButtonStyle {
  final double height;
  final double minWidth;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double borderRadius;

  static GonButtonTextStyle get small => GonButtonTextStyle(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: 4,
        minWidth: 48.toWidth,
        height: 26.toWidth,
        textStyle: GonStyle.caption(weight: FontWeight.w600),
      );

  static GonButtonTextStyle get regular => GonButtonTextStyle(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: 4,
        minWidth: 52.toWidth,
        height: 28.toWidth,
        textStyle: GonStyle.body2(weight: FontWeight.w600),
      );

  GonButtonTextStyle(
      {required this.padding,
      required this.height,
      required this.minWidth,
      required this.textStyle,
      required this.borderRadius});
}

/* THEME===================================================*/

class GonButtonColors {
  static const button_base_white = GonStyle.white;
  static const button_base_gray = GonStyle.gray040;
  static const button_base_magenta = GonStyle.primary050;
  static const button_base_lightMagenta = GonStyle.primary020;

  static const button_text_white = GonStyle.white;
  static const button_text_gray = GonStyle.gray070;
  static const button_text_deepGray = GonStyle.gray090;
  static const button_text_magenta = GonStyle.primary050;
  static const button_text_negationRed = GonStyle.negationRed;

  static const button_disabled_text_gray = GonStyle.gray060;
  static const button_disabled_base_gray = GonStyle.gray040;
  static const button_disabled_line_gray = GonStyle.gray050;

  static const button_line_negationRed = GonStyle.negationRed;

  static const button_loading_base_gray = GonStyle.gray040;
  static const button_loading_line_gray = GonStyle.gray050;
}

class GonButtonFillTheme extends GonButtonTheme {
  final Color baseColor;
  final Color textColor;
  final Color disabledBaseColor;
  final Color disabledTextColor;
  final Color loadingColor;

  static GonButtonFillTheme get lightMagenta => GonButtonFillTheme(
        baseColor: GonButtonColors.button_base_lightMagenta,
        textColor: GonButtonColors.button_text_magenta,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  static GonButtonFillTheme get magenta => GonButtonFillTheme(
        baseColor: GonButtonColors.button_base_magenta,
        textColor: GonButtonColors.button_text_white,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  static GonButtonFillTheme get gray => GonButtonFillTheme(
        baseColor: GonButtonColors.button_base_gray,
        textColor: GonButtonColors.button_text_gray,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  static GonButtonFillTheme get orange => GonButtonFillTheme(
        baseColor: Color(0xFFFF7742),
        textColor: GonButtonColors.button_text_white,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  static GonButtonFillTheme get thanksGiving => GonButtonFillTheme(
        baseColor: GonStyle.thanksGivingSecondary,
        textColor: GonButtonColors.button_text_white,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  static GonButtonFillTheme get blue => GonButtonFillTheme(
        baseColor: GonStyle.subBlue,
        textColor: GonButtonColors.button_text_white,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  static GonButtonFillTheme get lightBlue => GonButtonFillTheme(
        baseColor: GonStyle.subBlue10,
        textColor: GonStyle.subBlue,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  static GonButtonFillTheme custom({
    required Color baseColor,
    required Color textColor,
  }) =>
      GonButtonFillTheme(
        baseColor: baseColor,
        textColor: textColor,
        disabledBaseColor: GonButtonColors.button_disabled_base_gray,
        disabledTextColor: GonButtonColors.button_disabled_text_gray,
        loadingColor: GonButtonColors.button_loading_base_gray,
      );

  GonButtonFillTheme(
      {required this.baseColor,
      required this.textColor,
      required this.disabledBaseColor,
      required this.disabledTextColor,
      required this.loadingColor});
}

class GonButtonLineTheme extends GonButtonTheme {
  final Color baseColor;
  final Color textColor;
  final Color lineColor;
  final Color disabledBaseColor;
  final Color disabledTextColor;
  final Color disabledLineColor;
  final Color loadingColor;

  static GonButtonLineTheme get negationRed => GonButtonLineTheme(
      baseColor: GonButtonColors.button_base_white,
      textColor: GonButtonColors.button_text_negationRed,
      lineColor: GonButtonColors.button_line_negationRed,
      disabledBaseColor: GonButtonColors.button_base_white,
      disabledTextColor: GonButtonColors.button_disabled_text_gray,
      disabledLineColor: GonButtonColors.button_disabled_line_gray,
      loadingColor: GonButtonColors.button_loading_line_gray);

  static GonButtonLineTheme get deepGray => GonButtonLineTheme(
      baseColor: GonStyle.white,
      textColor: GonStyle.gray090,
      lineColor: GonStyle.gray050,
      disabledBaseColor: GonStyle.white,
      disabledTextColor: GonStyle.gray060,
      disabledLineColor: GonStyle.gray050,
      loadingColor: GonStyle.gray050);

  GonButtonLineTheme(
      {required this.baseColor,
      required this.textColor,
      required this.lineColor,
      required this.disabledBaseColor,
      required this.disabledTextColor,
      required this.disabledLineColor,
      required this.loadingColor});
}

class GonButtonIconTheme extends GonButtonTheme {
  final Color textColor;
  final Color disabledTextColor;

  static GonButtonIconTheme get deepGray => GonButtonIconTheme(
      textColor: GonButtonColors.button_text_deepGray,
      disabledTextColor: GonButtonColors.button_disabled_text_gray);

  static GonButtonIconTheme get white => GonButtonIconTheme(
      textColor: GonButtonColors.button_text_white,
      disabledTextColor: GonButtonColors.button_disabled_text_gray);

  GonButtonIconTheme(
      {required this.textColor, required this.disabledTextColor});

  GonButtonIconTheme copyWith({
    Color? textColor,
    Color? disabledTextColor,
  }) {
    return GonButtonIconTheme(
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
    );
  }
}

class GonButtonTextTheme extends GonButtonTheme {
  final Color textColor;
  final Color disabledTextColor;

  static GonButtonTextTheme get gray => GonButtonTextTheme(
      textColor: GonButtonColors.button_text_gray,
      disabledTextColor: GonButtonColors.button_disabled_text_gray);

  static GonButtonTextTheme get magenta => GonButtonTextTheme(
      textColor: GonButtonColors.button_text_magenta,
      disabledTextColor: GonButtonColors.button_disabled_text_gray);
  static GonButtonTextTheme get subBlue => GonButtonTextTheme(
      textColor: GonStyle.subBlue,
      disabledTextColor: GonButtonColors.button_disabled_text_gray);

  static GonButtonTextTheme get negationRed => GonButtonTextTheme(
      textColor: GonButtonColors.button_text_negationRed,
      disabledTextColor: GonButtonColors.button_disabled_text_gray);

  GonButtonTextTheme(
      {required this.textColor, required this.disabledTextColor});
}

class GonButtonOption {
  final String? text;
  final IconData? icon;
  final GonButtonTheme theme;
  final GonButtonStyle style;

  GonButtonOption.fill(
      {required this.text,
      required GonButtonFillTheme theme,
      required GonButtonFillStyle style})
      : theme = theme,
        style = style,
        icon = null;

  GonButtonOption.line(
      {required this.text,
      required GonButtonLineTheme theme,
      required GonButtonLineStyle style})
      : theme = theme,
        style = style,
        icon = null;

  GonButtonOption.icon(
      {required this.icon,
      required GonButtonIconTheme theme,
      required GonButtonIconStyle style})
      : theme = theme,
        style = style,
        text = '';

  GonButtonOption.text(
      {required this.text,
      required GonButtonTextTheme theme,
      required GonButtonTextStyle style})
      : theme = theme,
        style = style,
        icon = null;
}
