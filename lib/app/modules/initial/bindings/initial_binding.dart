import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../controllers/initial_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSources>(() => DataSources());
    Get.lazyPut<InitialController>(() => InitialController());
  }
}
