import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/settings.dart';

class SettingsController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  final settings = <Settings>[].obs;
  final state = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings;
  }

  get _loadSettings async {
    state.value = true;
    settings.value = await _dataSources.getSettings;
    state.value = false;
  }

  updateSettings(Settings settings) async {
    final data = await _dataSources.updateSettings(settings);
    return data;
  }
}
