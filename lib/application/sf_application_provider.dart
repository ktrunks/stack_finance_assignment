import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

/// application state
class SFApplicationProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool _connectionStatus;

  SFApplicationProvider() {
    debugPrint('application --- constructor');
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    debugPrint('network connectivity status --- $result');
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionStatus = true;
        break;
      case ConnectivityResult.mobile:
        _connectionStatus = true;
        break;
      case ConnectivityResult.none:
        _connectionStatus = false;
        break;
      default:
        _connectionStatus = false;
        break;
    }
    debugPrint('connection status --- $_connectionStatus');
  }

  bool getNetworkStatus() {
    return _connectionStatus;
  }
}
