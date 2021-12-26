import 'package:get/get.dart';
import 'package:wallet_online/app/data/data_sources/data_sources.dart';

class InitialController extends GetxController {
  final DataSources _dataSources = Get.put(DataSources());

  @override
  void onInit() {
    super.onInit();
    //loadApp;
  }

  get loadApp async {
    await _loadSettings;
    await _loadCategories;
    await _loadTransactions;
  }

  get _loadSettings async => await _dataSources.getSettings;
  get _loadCategories async => await _dataSources.getCategories;
  get _loadTransactions async => await _dataSources.getTransactions;
}
