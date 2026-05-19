import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkStatusService {
  factory NetworkStatusService() => _instance;

  NetworkStatusService._();

  static final NetworkStatusService _instance = NetworkStatusService._();

  final Connectivity _connectivity = Connectivity();
  final ValueNotifier<bool> isOnline = ValueNotifier<bool>(false);
  final StreamController<bool> _statusController =
      StreamController<bool>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isStarted = false;

  Stream<bool> get onStatusChanged => _statusController.stream;
  bool get lastKnownStatus => isOnline.value;

  void start() {
    if (_isStarted) {
      return;
    }

    _isStarted = true;
    _subscription = _connectivity.onConnectivityChanged.listen(_handleResults);
    unawaited(_connectivity.checkConnectivity().then(_handleResults));
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    _isStarted = false;
  }

  Future<bool> checkNow() async {
    final results = await _connectivity.checkConnectivity();
    return _handleResults(results);
  }

  bool _handleResults(List<ConnectivityResult> results) {
    final connected = results.any(
      (result) => result != ConnectivityResult.none,
    );
    if (connected != isOnline.value) {
      isOnline.value = connected;
      _statusController.add(connected);
    }
    return connected;
  }

  void dispose() {
    stop();
  }
}

class ConnectionMonitor {
  factory ConnectionMonitor() => _instance;

  ConnectionMonitor._();

  static final ConnectionMonitor _instance = ConnectionMonitor._();
  final NetworkStatusService _networkStatusService = NetworkStatusService();

  Stream<bool> get onStatusChanged => _networkStatusService.onStatusChanged;
  bool? get lastKnownStatus => _networkStatusService.lastKnownStatus;

  void start() => _networkStatusService.start();

  void stop() => _networkStatusService.stop();

  Future<bool> checkNow() => _networkStatusService.checkNow();

  void dispose() => _networkStatusService.dispose();
}
