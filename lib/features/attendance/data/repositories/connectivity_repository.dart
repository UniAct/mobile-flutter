import 'package:mobile_flutter/core/utils/connection_monitor.dart';

/// Repository for backend reachability monitoring.
class ConnectivityRepository {
  ConnectivityRepository({ConnectionMonitor? monitor})
    : _monitor = monitor ?? ConnectionMonitor();

  final ConnectionMonitor _monitor;

  bool? _lastKnown;

  Stream<bool> get onConnectivityChanged {
    _monitor.start();
    return _monitor.onStatusChanged.map((connected) {
      _lastKnown = connected;
      return connected;
    });
  }

  Future<bool> isConnected() async {
    final known = _lastKnown ?? _monitor.lastKnownStatus;
    if (known != null) {
      _lastKnown = known;
      return known;
    }

    _monitor.start();
    final result = await _monitor.onStatusChanged.first
        .timeout(const Duration(seconds: 5), onTimeout: () => false)
        .catchError((_) => false);
    _lastKnown = result;
    return result;
  }

  Future<bool> checkNow() async {
    _monitor.start();
    final result = await _monitor
        .checkNow()
        .timeout(const Duration(seconds: 5), onTimeout: () => false)
        .catchError((_) => false);
    _lastKnown = result;
    return result;
  }
}
