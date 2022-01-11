import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/categories.dart';

class CategoriesController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  final categories = <Categories>[].obs;
  final state = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories;
  }

  get _loadCategories async {
    state.value = true;
    categories.value = await _dataSources.getCategories;
    state.value = false;
  }

  addCategory(Categories category) async {
    final data = await _dataSources.insertCategory(category);
    _loadCategories;
    return data;
  }

  updateCategory(Categories category) async {
    final data = await _dataSources.updateCategory(category);
    _loadCategories;
    return data;
  }

  deleteCategory(int id) async {
    final data = await _dataSources.deleteCategory(id);
    _loadCategories;
    return data;
  }
}
