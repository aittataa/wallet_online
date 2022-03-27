import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/categories.dart';

class CategoriesController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Categories>> get loadCategories async {
    return await _dataSources.getCategories;
  }

  addCategory(Categories category) async {
    return await _dataSources.insertCategory(category);
  }

  updateCategory(Categories category) async {
    return await _dataSources.updateCategory(category);
  }

  deleteCategory(int id) async {
    return await _dataSources.deleteCategory(id);
  }
}
