import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';

class AppFunction {
  AppFunction._();

  static lunchNew(context, {required Widget builder}) {
    return showCupertinoModalPopup(
      barrierColor: AppTheme.secondaryBackColor.withOpacity(.5),
      context: context,
      builder: (context) => builder,
    );
  }

  static loadCount(List myList, int state) {
    try {
      return myList
          .where((transaction) => transaction.state == state)
          .toList()
          .map((transaction) => transaction.amount)
          .reduce((a, b) => a! + b!);
    } catch (e) {
      return 0.0;
    }
  }

  static int get getRandomColor => Color(Random().nextInt(0xFFFFFFFF)).withAlpha(0xFF).value;

  static String dateShape(DateTime date) => DateFormat('MMM dd, yyyy').format(date);

  static int getCategoryID(String value, List myList) {
    return myList.where((category) => category.title == value).toList()[0].id;
  }

  static snackBar({required String title, required String message}) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: AppTheme.mainColor,
      margin: EdgeInsets.all(10),
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
    );
  }

  static animateToPage(int index) {
    AppConstant.pageIndex = index;
    AppConstant.pageController.animateToPage(
      AppConstant.pageIndex,
      duration: AppConstant.durationPage,
      curve: AppConstant.curve,
    );
  }

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
