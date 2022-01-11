import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color incomeColor = Color(0xff08ff00);
  static const Color expenseColor = Color(0xfffd0000);

  static const Color mainColor = Color(0xFFFF6051);
  static const Color backgroundColor = Color(0xFFF0F0F0);
  static const Color primaryBackColor = Color(0xFFFFFFFF);
  static const Color secondaryBackColor = Color(0xFF000000);
  static const Color transparentColor = Color(0x00000000);
  static const Color shadowColor = Color(0x1F000000);

  /// TODO : Icons
  static const Color primaryIconColor = Color(0xFF000000);
  static const Color secondaryIconColor = Color(0xFFFFFFFF);

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
      ),
    );
  }
}
