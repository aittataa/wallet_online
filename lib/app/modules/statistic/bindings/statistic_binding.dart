import 'package:get/get.dart';

import '../controllers/statistic_controller.dart';

class StatisticBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticController>(
      () => StatisticController(),
    );
  }
}
