import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/settings.dart';

class InitialController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  final settings = Settings().obs;
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

  Future<Settings> get loadSettings async {
    final Settings settings = await _dataSources.getSettings;
    return settings;
  }
}
