import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSources>(() => DataSources());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
