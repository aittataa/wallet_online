import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/modules/initial/views/initial_view.dart';
import 'package:wallet_online/app/shared/bounce_point.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: BouncePoint(size: 60),
      nextScreen: InitialView(),
      curve: AppConstant.curve,
      backgroundColor: AppTheme.primaryBackColor,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      animationDuration: AppConstant.durationSplash,
    );
  }
}
