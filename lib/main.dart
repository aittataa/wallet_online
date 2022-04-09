import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wallet_online/app/config/app_constant.dart';

import 'app/config/app_function.dart';
import 'app/config/app_theme.dart';
import 'app/config/app_translation.dart';
import 'app/shared/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppFunction.configureDependencies;
  initializeDateFormatting();
  runApp(const WalletOnline());
}

class WalletOnline extends StatelessWidget {
  const WalletOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppKey.appTitle.name.tr,
      theme: AppTheme.themeData,
      translations: AppTranslation(),
      locale: Locale(AppConstant.language),
      // home: InitialView(),
      home: Splash(),
    );
  }
}
