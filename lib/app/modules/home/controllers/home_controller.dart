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
  }

  Future<Settings> get getSettings async {
    final Settings settings = await _dataSources.getSettings;
    return settings;
  }

  Future<List<Categories>> get getCategories async {
    final List<Categories> categories = await _dataSources.getCategories;
    return categories;
  }

  Future<Categories> getCategory(int id) async {
    final Categories category = await _dataSources.getCategory(id);
    return category;
  }

  Future<List<Transactions>> get getTransactions async {
    List<Transactions> transactions = await _dataSources.getTransactions;
    return transactions;
  }

  addTransaction(Transactions transaction) async {
    return await _dataSources.insertTransaction(transaction);
  }

  deleteTransaction(int id) async {
    return await _dataSources.deleteTransaction(id);
  }
}
