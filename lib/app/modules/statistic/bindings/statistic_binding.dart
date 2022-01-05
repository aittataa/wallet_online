import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../controllers/statistic_controller.dart';

class StatisticBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSources>(() => DataSources());
    Get.lazyPut<StatisticController>(() => StatisticController());
  }
}
