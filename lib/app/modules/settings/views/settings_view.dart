import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/settings.dart';
import 'package:wallet_online/app/modules/home/widgets/dropdown_list.dart';
import 'package:wallet_online/app/modules/initial/views/initial_view.dart';
import 'package:wallet_online/app/modules/settings/controllers/settings_controller.dart';
import 'package:wallet_online/app/shared/add_button.dart';
import 'package:wallet_online/app/shared/bounce_point.dart';
import 'package:wallet_online/app/shared/empty_box.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsController controller = Get.put(SettingsController());
  late String selectedCurrency;
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedCurrency = AppConstant.appCurrency;
    selectedLanguage = AppMessage.languageEN;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMessage.labelSettings)),
      body: Obx(() {
        final bool state = controller.state.value;
        if (state) {
          return BouncePoint();
        } else {
          final List<Settings> myList = controller.settings;

          final bool isNotEmpty = myList.isNotEmpty;
          if (isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 250,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [AppConstant.boxShadow],
                      image: DecorationImage(image: AssetImage(AppMessage.appIconRound)),
                    ),
                  ),
                  /*
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    minVerticalPadding: 0,
                    leading: SizedBox(
                      width: 100,
                      child: Text(
                        "${AppMessage.languageLabel} :",
                        style: TextStyle(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    title: DropdownList(
                      hint: AppMessage.languageLabel,
                      value: selectedLanguage,
                      onChanged: (value) async {
                        setState(() => selectedLanguage = value);
                      },
                      myList: List.generate(AppConstant.languageList.length, (index) {
                        String language = AppConstant.languageList[index];
                        return DropdownMenuItem(
                          value: language,
                          child: Text(
                            language,
                            style: const TextStyle(
                              color: AppTheme.primaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  */
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    minVerticalPadding: 0,
                    leading: SizedBox(
                      width: 100,
                      child: Text(
                        "${AppMessage.currencyLabel} :",
                        style: TextStyle(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    title: DropdownList(
                      hint: AppMessage.currencyLabel,
                      value: selectedCurrency,
                      onChanged: (value) async {
                        setState(() => selectedCurrency = value);
                      },
                      myList: List.generate(AppConstant.currencyList.length, (index) {
                        String currency = AppConstant.currencyList[index];
                        return DropdownMenuItem(
                          value: currency,
                          child: Text(
                            currency,
                            style: TextStyle(
                              color: AppTheme.primaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  ListTile(
                    title: AddButton(
                      title: AppMessage.labelSave,
                      color: AppTheme.mainColor,
                      onPressed: () async {
                        final data = await controller.updateSettings(
                          Settings(id: 1, currency: selectedCurrency),
                        );
                        if (data != null) {
                          AppConstant.appCurrency = selectedCurrency;
                          Get.offAll(() => InitialView(pageIndex: 3));
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return EmptyBox();
          }
        }
      }),
    );
  }
}
