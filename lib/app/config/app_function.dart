import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'app_constant.dart';
import 'app_theme.dart';

class AppFunction {
  AppFunction._();

  static messageBox({required String message}) {
    return Get.snackbar(
      "",
      "",
      backgroundColor: AppTheme.mainColor,
      margin: const EdgeInsets.only(bottom: 64),
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      maxWidth: 200,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 100,
      duration: AppConstant.durationSnack,
      messageText: const SizedBox(),
      titleText: Text(
        "$message",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.secondaryTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static lunchNew(context, {required Widget builder}) {
    return showCupertinoModalPopup(
      barrierColor: AppTheme.secondaryBackColor.withOpacity(.5),
      context: context,
      builder: (context) => builder,
    );
  }

  static loadCount(List myList, int state) {
    try {
      return myList.where((transaction) => transaction.state == state).toList().map((transaction) => transaction.amount).reduce((a, b) => a! + b!);
    } catch (e) {
      return 0.0;
    }
  }

  static int get getRandomColor => Color(Random().nextInt(0xFFFFFFFF)).withAlpha(0xFF).value;

  static String dateShape(DateTime date) => DateFormat('MMM dd, yyyy').format(date);

  static String datetimeShape(DateTime date) => DateFormat('MMM dd, yyyy - HH:MM').format(date);

  static int getCategoryID(String value, List myList) {
    return myList.where((category) => category.title == value).toList()[0].id;
  }

  static filterList(List myList, int state) {
    return myList.where((category) => category.state == state).toList();
  }

  static filterCategories(List myList, int state) {
    return myList.where((category) => category.state == state).toList();
  }

  static filterStatistics(List myList, int state) {
    return myList.where((category) => category.state == state && category.total > 0).toList();
  }

  static snackBar({required String title, required String message}) {
    return Get.snackbar(
      "",
      "",
      backgroundColor: AppTheme.expenseColor,
      margin: EdgeInsets.only(top: 25, right: 15, left: 15),
      duration: AppConstant.durationSnack,
      titleText: Text(
        title,
        style: TextStyle(
          color: AppTheme.secondaryTextColor,
          fontWeight: FontWeight.bold,
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
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.transparentColor,
        // systemNavigationBarDividerColor: AppTheme.transparentColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
        statusBarColor: AppTheme.transparentColor,
        // statusBarIconBrightness: Brightness.light,
        // statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: true,
      ),
    );
  }
}
