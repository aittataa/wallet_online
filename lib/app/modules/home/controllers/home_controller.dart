import 'package:get/get.dart';
import 'package:wallet_online/app/data/data_sources/data_sources.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/data/models/transactions.dart';

class HomeController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());
  var transactions = <Transactions>[].obs;
  var categories = <Categories>[].obs;
  var state = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories;
    loadTransactions;
  }

  get loadTransactions async {
    state.value = true;
    transactions.value = await _dataSources.getTransactions;
    state.value = false;
  }

  get loadCategories async {
    state.value = true;
    categories.value = await _dataSources.getCategories;
    state.value = false;
  }

  addTransaction(Transactions transaction) async {
    var data = _dataSources.insertTransaction(transaction);
    return data;
  }

  deleteTransaction(int id) async {
    var data = await _dataSources.deleteTransaction(id);
    return data;
  }
}
