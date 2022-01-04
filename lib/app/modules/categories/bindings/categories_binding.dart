import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../controllers/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSources>(() => DataSources());
    Get.lazyPut<CategoriesController>(() => CategoriesController());
  }
}
