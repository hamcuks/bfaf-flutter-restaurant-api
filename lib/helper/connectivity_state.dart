import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityState {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnectedToNetwork() async {
    ConnectivityResult _connectivityResult =
        await _connectivity.checkConnectivity();

    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
