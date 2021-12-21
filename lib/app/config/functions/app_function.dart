import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';

class AppFunction {
  AppFunction._();

  static loadCount(List myList) {
    try {
      return myList.map((transaction) => transaction.amount).reduce((a, b) => a! + b!);
    } catch (e) {
      return 0.0;
    }
  }

  static int get getRandomColor => Color(Random().nextInt(0xFFFFFFFF)).withAlpha(0xFF).value;

  static String dateShape(DateTime date) => DateFormat('MMM dd, yyyy').format(date);

  /*
  static snackBar({required String title, required String message}) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: AppTheme.mainColor,
      titleText: Text(
        title,
        style: TextStyle(
          color: AppTheme.secondaryTextColor,
          fontWeight: FontWeight.w900,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: AppTheme.secondaryTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      margin: EdgeInsets.all(10),
    );
  }
  */

  // static animateToPage(int index) {
  //   AppConstant.pageIndex = index;
  //   AppConstant.controller.jumpToPage(
  //     AppConstant.pageIndex,
  //   );
  // }

  /*
  static gridDelegate({
    int crossAxisCount = 1,
    double spacing = 10,
    double childAspectRatio = 1,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
    );
  }
  */

  static get configureDependencies {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.primaryBackColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppTheme.transparentColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }
}
