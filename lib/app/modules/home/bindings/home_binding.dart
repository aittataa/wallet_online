import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSources>(() => DataSources());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
