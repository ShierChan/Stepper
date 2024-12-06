import 'package:flutter/material.dart';

/// primary: 应用中最常用颜色
///
/// onPrimary：此颜色用于为原色之上的元素（例如文本、图标等）着色。
///
/// secondary：这定义了一种辅助颜色，通常用于不太显眼的元素，如滤镜芯片、切换按钮或背景元素，这些元素需要从主色中脱颖而出，但又不能喧宾夺主。
///
/// onSecondary：该颜色用于为次要颜色上的元素着色。
///
/// error：这是用于错误消息或警报的颜色，例如闪烁的红灯表示问题。
///
/// onError：这是与 error 颜色相得益彰的文本颜色，例如红色标志上的白色文本，便于阅读。
///
/// surface：用作卡片、工作表、对话框等高级 UI 元素的基色。
class GlobalTheme {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);
  static ThemeData themeData(
      ColorScheme colorScheme, Color focusColor, Color textColor) {
    return ThemeData(
        colorScheme: colorScheme,
        canvasColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: textColor),
          bodyMedium: TextStyle(color: textColor),
          titleLarge: TextStyle(color: textColor),
          displayLarge: TextStyle(color: textColor),
          displayMedium: TextStyle(color: textColor),
          displaySmall: TextStyle(color: textColor),
        ));
  }

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor, Colors.black);
  static ThemeData darkThemeData =
      themeData(darkColorScheme, _darkFocusColor, Colors.white);

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    secondary: Color(0xFFD3DDE4),
    surface: Color(0xFF2f2f48),
    onSurface: Color(0x0DFFFFFF),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Color(0xFF2f2f48),
    onSecondary: Color(0xFF2f2f48),
    brightness: Brightness.dark,
  );
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    secondary: Color(0xFFEEEED1),
    surface: Colors.white,
    onSurface: Color(0xFFFDF5E6),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Color(0xFF2f2f48),
    onSecondary: Color(0xFF2f2f48),
    brightness: Brightness.light,
  );
  static Color containerColor = const Color(0xFF2f2f48);
}
