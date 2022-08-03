import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/app_translation.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_enum.dart';
import '../../../config/app_function.dart';
import '../../../config/app_message.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/settings.dart';
import '../../../shared/bounce_point.dart';
import '../../../shared/dropdown_list.dart';
import '../../../shared/outline_button.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppKey.labelSettings.name.tr)),
      body: Obx(() {
        final bool state = controller.state.value;
        if (state) {
          return BouncePoint();
        } else {
          // final Settings appSettings = controller.settings.value;
          // AppConstant.currency = appSettings.currency!;
          // AppConstant.appCurrency = AppEnum.currencies[appSettings.currency]!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                /// TODO : Logo
                Container(
                  width: 150,
                  height: 250,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(AppMessage.settings_icon)),
                  ),
                ),

                /// TODO : Currencies
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  minVerticalPadding: 0,
                  leading: SizedBox(
                    width: 100,
                    child: Text(
                      AppKey.currencyLabel.name.tr,
                      style: TextStyle(
                        color: AppTheme.primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: DropdownList(
                    hint: AppKey.currencyLabel.name.tr,
                    value: AppConstant.currency,
                    onChanged: (value) {
                      print(value);
                      setState(() => AppConstant.currency = value);
                    },
                    myList: List.generate(AppCurrencies.values.length, (i) {
                      final String _index = AppCurrencies.values[i].name;
                      final String _currency = AppEnum.currencies[_index]!;
                      return DropdownMenuItem(
                        value: _index,
                        child: Text(
                          "$_currency",
                          style: TextStyle(
                            color: AppTheme.primaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                /// TODO : Languages
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  minVerticalPadding: 0,
                  leading: SizedBox(
                    width: 100,
                    child: Text(
                      AppKey.languageLabel.name.tr,
                      style: TextStyle(
                        color: AppTheme.primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: DropdownList(
                    hint: AppKey.languageLabel.name.tr,
                    value: AppConstant.language,
                    onChanged: (value) {
                      print(value);
                      setState(() => AppConstant.language = value);
                    },
                    myList: List.generate(AppLanguages.values.length, (i) {
                      final String _index = AppLanguages.values[i].name;
                      final String _language = AppEnum.languages[_index]!;
                      return DropdownMenuItem(
                        value: _index,
                        child: Text(
                          "$_language",
                          style: TextStyle(
                            color: AppTheme.primaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                /// TODO : Save Button
                ListTile(
                  title: OutlineButton(
                    title: AppKey.labelSave.name.tr,
                    color: AppTheme.mainColor,
                    onPressed: () async {
                      final data = await controller.updateSettings(
                        Settings(
                          id: 1,
                          currency: AppConstant.currency,
                          language: AppConstant.language,
                        ),
                      );
                      Get.updateLocale(Locale(AppConstant.language));
                      if (!(data == null)) {
                        AppConstant.appCurrency = AppEnum.currencies[AppConstant.currency]!;
                        AppConstant.appLanguage = AppEnum.languages[AppConstant.language]!;
                        AppFunction.messageBox(message: AppKey.messageUpdate.name.tr);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SettingsController>();
  }
}
