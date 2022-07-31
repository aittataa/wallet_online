import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallet_online/app/data/models/settings.dart';
import 'package:wallet_online/app/modules/initial/controllers/initial_controller.dart';

import '../config/app_constant.dart';
import '../config/app_message.dart';
import '../config/app_theme.dart';
import '../modules/initial/views/initial_view.dart';
import '../shared/bounce_point.dart';

class Splash extends StatelessWidget {
  final InitialController controller = Get.put(InitialController());

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      screenFunction: () async {
        final Settings settings = await controller.loadSettings;
        AppConstant.language = settings.language!;
        AppConstant.currency = settings.currency!;
        Get.updateLocale(Locale(AppConstant.language));
        return InitialView();
      },
      splash: Column(
        children: [
          Expanded(flex: 3, child: Image.asset(AppMessage.splash_icon, width: 200, height: 200)),
          Expanded(child: BouncePoint(size: 60)),
        ],
      ),
      //nextScreen: InitialView(),
      curve: AppConstant.curve,
      backgroundColor: AppTheme.primaryBackColor,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      animationDuration: AppConstant.durationSplash,
      splashIconSize: double.infinity,
    );
  }
}
