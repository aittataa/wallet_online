import 'package:get/get.dart';
import 'package:wallet_online/app/data/data_sources/data_sources.dart';
import 'package:wallet_online/app/data/models/settings.dart';

class SettingsController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  var settings = <Settings>[].obs;
  var state = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories;
  }

  get loadCategories async {
    state.value = true;
    settings.value = await _dataSources.getSettings;
    state.value = false;
  }

  updateSettings(Settings settings) async {
    var data = _dataSources.updateSettings(settings);
    return data;
  }
}
