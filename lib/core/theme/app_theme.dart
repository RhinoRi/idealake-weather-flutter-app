import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData appMainTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors().primaryColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors().primaryColor,
      surface: AppColors().backgroundColor,
      onSurface: AppColors().textColor,
    ),
    scaffoldBackgroundColor: AppColors().backgroundColor,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors().backgroundColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors().textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(size: 24, color: AppColors().primaryColor)),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColors().textColor,
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors().textColor,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: AppColors().textColor,
        fontSize: 26,
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}
