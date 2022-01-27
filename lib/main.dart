import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/shared/splash.dart';

import 'app/config/app_function.dart';
import 'app/config/app_message.dart';
import 'app/config/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppFunction.configureDependencies;
  runApp(const WalletOnline());
}

class WalletOnline extends StatelessWidget {
  const WalletOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppMessage.appTitle,
      theme: AppTheme.themeData,
      //home: InitialView(),
      home: Splash(),
    );
  }
}
