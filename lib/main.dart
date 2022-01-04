import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/functions/app_function.dart';
import 'app/config/messages/app_message.dart';
import 'app/config/themes/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/splash.dart';

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
      getPages: AppPages.routes,
      home: Splash(),
    );
  }
}
