import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_enum.dart';
import '../../../config/app_function.dart';
import '../../../config/app_message.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/settings.dart';
import '../../../shared/add_button.dart';
import '../../../shared/bounce_point.dart';
import '../../../shared/dropdown_list.dart';
import '../../../shared/empty_box.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsController controller = Get.put(SettingsController());
  late String selectedCurrency;
  late String selectedLanguage;
  late Currencies currencies;

  @override
  void initState() {
    super.initState();
    // selectedCurrency = AppConstant.appCurrency;
    // selectedLanguage = Languages.English.name;
    selectedCurrency = AppEnum.currencies.values.first;
    currencies = Currencies.MAD;
    selectedLanguage = AppEnum.languages.values.first;
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
                      image: DecorationImage(image: AssetImage(AppMessage.appLogo)),
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
                        "${AppMessage.currencyLabel} : ",
                        style: TextStyle(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: DropdownList(
                      hint: AppMessage.currencyLabel,
                      value: currencies,
                      onChanged: (value) async {
                        print(currencies.name);
                        setState(() => currencies = value);
                      },
                      myList: List.generate(Currencies.values.length, (i) {
                        final Currencies index = Currencies.values[i];
                        final String? currency = AppEnum.currencies[index];
                        return DropdownMenuItem(
                          value: index,
                          child: Text(
                            "$currency",
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
                  /*ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    minVerticalPadding: 0,
                    leading: SizedBox(
                      width: 100,
                      child: Text(
                        "${AppMessage.languageLabel} : ",
                        style: TextStyle(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: DropdownList(
                      hint: AppMessage.languageLabel,
                      value: selectedLanguage,
                      onChanged: (value) async {
                        setState(() => selectedLanguage = value);
                      },
                      myList: List.generate(Languages.values.length, (i) {
                        // final String language = Languages.values[i].name;
                        final Languages index = Languages.values[i];
                        final String? language = AppEnum.languages[index];
                        return DropdownMenuItem(
                          value: language,
                          child: Text(
                            "$language",
                            style: TextStyle(
                              color: AppTheme.primaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),*/

                  /// TODO : Save Button
                  ListTile(
                    title: AddButton(
                      title: AppMessage.labelSave,
                      color: AppTheme.mainColor,
                      onPressed: () async {
                        final data = await controller.updateSettings(
                          Settings(id: 1, currency: selectedCurrency),
                        );
                        if (!(data == null)) {
                          AppConstant.appCurrency = selectedCurrency;
                          AppFunction.messageBox(message: AppMessage.messageUpdate);
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

  @override
  void dispose() {
    super.dispose();
    Get.delete<SettingsController>();
  }
}
