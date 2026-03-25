import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:mobile_flutter/core/config/app_config.dart';

class ConnectionMonitor {
  factory ConnectionMonitor() => _instance;

  ConnectionMonitor._();

  static final ConnectionMonitor _instance = ConnectionMonitor._();

  static const Duration _interval = Duration(seconds: 6);
  static const Duration _timeout = Duration(seconds: 4);

  final StreamController<bool> _statusController =
      StreamController<bool>.broadcast();

  Timer? _timer;
  bool? _lastKnownConnected;
  bool _isStarted = false;

  Stream<bool> get onStatusChanged => _statusController.stream;

  void start() {
    if (_isStarted) {
      return;
    }
    _isStarted = true;
    _checkStatus();
    _timer = Timer.periodic(_interval, (_) => _checkStatus());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _isStarted = false;
  }

  void dispose() {
    stop();
    _statusController.close();
  }

  Future<void> _checkStatus() async {
    final connected = await _isBackendReachable();

    if (_lastKnownConnected == null) {
      _lastKnownConnected = connected;
      return;
    }

    if (connected != _lastKnownConnected) {
      _lastKnownConnected = connected;
      _statusController.add(connected);
    }
  }

  Future<bool> _isBackendReachable() async {
    try {
      final uri = Uri.parse('${AppConfig.baseUrl}/university/list');
      final response = await http.get(uri).timeout(_timeout);
      return response.statusCode < 500;
    } catch (_) {
      return false;
    }
  }
}
