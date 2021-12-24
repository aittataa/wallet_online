import 'package:get/get.dart';
import 'package:wallet_online/app/data/data_sources/data_sources.dart';
import 'package:wallet_online/app/data/models/categories.dart';

class CategoriesController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  var categories = <Categories>[].obs;
  var state = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories;
  }

  get loadCategories async {
    state.value = true;
    categories.value = await _dataSources.getCategories;
    state.value = false;
  }

  addCategory(Categories category) async {
    var data = await _dataSources.insertCategory(category);
    loadCategories;
    return data;
  }

  updateCategory(Categories category) async {
    var data = await _dataSources.updateCategory(category);
    loadCategories;
    return data;
  }

  deleteCategory(int id) async {
    var data = await _dataSources.deleteCategory(id);
    return data;
  }
}
