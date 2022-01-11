import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_message.dart';
import 'app_theme.dart';

class AppConstant {
  AppConstant._();

  /// TODO : Screen Controller
  static String appCurrency = AppMessage.currencyMAD;

  /// TODO : Screen Controller
  static PageController pageController = PageController();
  static int pageIndex = 0;

  /// TODO : Screen Size
  static double screenWidth = Get.width;
  static double screenHeight = Get.height;

  static const double elevation = 1;

  /// TODO : Curves
  static const Curve curve = Curves.linearToEaseOut;

  /// TODO : Transitions
  static const Transition transitionRoute = Transition.fadeIn;

  /// TODO : Durations
  static const Duration duration = Duration(milliseconds: 1500);
  static const Duration durationPage = Duration(milliseconds: 500);
  static const Duration durationSwap = Duration(milliseconds: 1000);
  static const Duration durationSplash = Duration(milliseconds: 1500);
  static const Duration durationSnack = Duration(milliseconds: 1500);

  /// TODO : Currency List
  static const List<String> currencyList = [
    AppMessage.currencyMAD,
    AppMessage.currencyUSD,
    AppMessage.currencyEUR,
  ];

  /// TODO : BoxShadow
  static BoxShadow boxShadow = BoxShadow(
    color: AppTheme.shadowColor.withOpacity(.1),
    blurRadius: 10,
    spreadRadius: .1,
  );
}
