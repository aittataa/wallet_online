import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color incomeColor = Color(0xff08ff00);
  static const Color expenseColor = Color(0xfffd0000);

  // static const Color mainColor = Color(0xFFFEC915);
  // static const Color mainColor = Color(0xFFFF8500);
  static const Color mainColor = Color(0xFFFF6051); //0xFFFF4C3B
  static const Color backgroundColor = Color(0xFFF0F0F0);
  static const Color backgroundImageColor = Color(0xFFFFFFFF); //F8F8F8
  static const Color primaryBackColor = Color(0xFFFFFFFF);
  static const Color secondaryBackColor = Color(0xFF000000); //BDBDBD
  static const Color transparentColor = Color(0x00000000);
  static const Color shadowColor = Color(0x1F000000);
  static const Color borderColor = Color(0xFF000000);

  /// TODO : Icons
  static const Color mainIconColor = Color(0xFFF44336);
  static const Color primaryIconColor = Color(0xFF000000);
  static const Color secondaryIconColor = Color(0xFFFFFFFF);

  /// TODO : Field Text Colors
  static const Color fieldTextBackground = Color(0xFFE5E5E5);

  /// TODO : Texts
  static const Color primaryTextColor = Color(0xFF000000);
  static const Color secondaryTextColor = Color(0xFFFFFFFF);

  static ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: AppTheme.backgroundColor,
      primaryColor: AppTheme.backgroundColor,
      splashColor: AppTheme.backgroundColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppTheme.mainColor,
        titleTextStyle: TextStyle(
          color: AppTheme.secondaryTextColor,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: AppTheme.secondaryIconColor,
          size: 30,
        ),
        actionsIconTheme: IconThemeData(
          color: AppTheme.secondaryIconColor,
          size: 30,
        ),
      ),
    );
  }
}
