import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';

class AppConstant {
  AppConstant._();

  /// TODO : Screen Size
  static double screenWidth = Get.width;
  static double screenHeight = Get.height;

  /// TODO : Curves
  static const Curve curve = Curves.linearToEaseOut;

  /// TODO : Transitions
  static const Transition transitionRoute = Transition.fadeIn;

  /// TODO : Durations
  static const Duration duration = Duration(milliseconds: 1500);
  static const Duration durationPage = Duration(milliseconds: 1000);
  static const Duration durationSwap = Duration(milliseconds: 1000);
  static const Duration durationRoute = Duration(milliseconds: 100);
  static const Duration durationSplash = Duration(milliseconds: 1500);
  //static const Duration durationAnimation = Duration(milliseconds: 1000);
  //static const Duration durationContainer = Duration(milliseconds: 1000);

  /// TODO : BoxShadow
  static BoxShadow boxShadow = BoxShadow(
    color: AppTheme.shadowColor.withOpacity(.1),
    blurRadius: 10,
    spreadRadius: .1,
  );
}
