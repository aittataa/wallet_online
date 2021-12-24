import 'package:get/get.dart';
import 'package:wallet_online/app/data/data_sources/data_sources.dart';
import 'package:wallet_online/app/modules/initial/controllers/initial_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataSources>(() => DataSources());
    Get.lazyPut<InitialController>(() => InitialController());
  }
}
