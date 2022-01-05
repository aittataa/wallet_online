import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_constant.dart';
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

  @override
  void initState() {
    super.initState();
    selectedCurrency = AppConstant.appCurrency;
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
                      image: DecorationImage(image: AssetImage(AppMessage.appLogo)),
                    ),
                  ),
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
                        AppConstant.appCurrency = selectedCurrency;
                        print(data);
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
