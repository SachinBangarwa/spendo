import 'package:flutter/material.dart';
import 'package:spendo/theme/color_manager.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.primary,
    cardColor: ColorManager.lightCard,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(size: 32),
      titleTextStyle: TextStyle(
          fontSize: 18,
          letterSpacing: 0,
          fontWeight: FontWeight.w600,
          color: ColorManager.lightText),
      backgroundColor: ColorManager.lightBackground,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        letterSpacing: 0,
        color: ColorManager.lightText,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.darkBackground,
    cardColor: ColorManager.darkCard,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ColorManager.darkText),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primary,
    ),
  );
}
