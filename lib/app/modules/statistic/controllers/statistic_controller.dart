import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/categories.dart';
import '../../../data/models/settings.dart';

class StatisticController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  final statistics = <Categories>[].obs;
  final settings = Settings().obs;

  final state = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings;
    _loadStatistics;
  }

  get _loadSettings async {
    state.value = true;
    settings.value = await _dataSources.getSettings;
    state.value = false;
  }

  get _loadStatistics async {
    state.value = true;
    statistics.value = await _dataSources.getStatistics;
    state.value = false;
  }

  Future<List<Categories>> get loadStatistics async {
    return await _dataSources.getStatistics;
  }
}
