import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/categories.dart';
import '../../../data/models/settings.dart';
import '../../../data/models/transactions.dart';

class HomeController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  final settings = Settings().obs;
  final state = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings;
  }

  get _loadSettings async {
    state.value = true;
    settings.value = await _dataSources.getSettings;
    state.value = false;
  }

  Future<List<Categories>> get loadCategories async {
    return await _dataSources.getCategories;
  }

  Future<List<Transactions>> get loadTransactions async {
    return await _dataSources.getTransactions;
  }

  addTransaction(Transactions transaction) async {
    return await _dataSources.insertTransaction(transaction);
  }

  deleteTransaction(int id) async {
    return await _dataSources.deleteTransaction(id);
  }
}
