import 'package:get/get.dart';
import 'package:wallet_online/app/data/models/transactions.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/categories.dart';

class StatisticController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  final categories = <Categories>[].obs;
  final statistics = <Transactions>[].obs;
  final state = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStatistics;
  }

  get _loadStatistics async {
    state.value = true;
    categories.value = await _dataSources.getCategories;
    state.value = false;
  }
}
