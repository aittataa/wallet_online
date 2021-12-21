import 'package:get/get.dart';
import 'package:wallet_online/app/data/data_sources/data_sources.dart';
import 'package:wallet_online/app/data/models/categories.dart';

class StatisticController extends GetxController {
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
}
