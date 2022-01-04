import 'package:connectivity/connectivity.dart';

class Network {
  static Future<bool> get hasConnection async {
    var result = await (Connectivity().checkConnectivity());
    switch (result) {
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.none:
        return false;
      default:
        return false;
    }
  }
}
