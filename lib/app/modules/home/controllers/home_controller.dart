import 'package:get/get.dart';

import '../../../data/data_sources/data_sources.dart';
import '../../../data/models/categories.dart';
import '../../../data/models/transactions.dart';

class HomeController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  final transactions = <Transactions>[].obs;
  final categories = <Categories>[].obs;
  final state = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories;
    loadTransactions;
  }

  get _loadCategories async {
    state.value = true;
    categories.value = await _dataSources.getCategories;
    state.value = false;
  }

  Future<List<Transactions>> get loadTransactions async {
    final response = await _dataSources.getTransactions;
    //print(response);
    return response;
  }

  get _loadTransactions async {
    state.value = true;
    transactions.value = await _dataSources.getTransactions;
    state.value = false;
  }

  addTransaction(Transactions transaction) async {
    final data = _dataSources.insertTransaction(transaction);
    loadTransactions;
    _loadTransactions;
    return data;
  }

  deleteTransaction(int id) async {
    final data = await _dataSources.deleteTransaction(id);
    loadTransactions;
    _loadTransactions;
    return data;
  }
}
