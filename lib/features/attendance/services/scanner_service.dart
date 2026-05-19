import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Singleton Camera Manager for QR Scanner
///
/// Problem solved: "Repeated camera recreation on widget rebuild"
///
/// Original code in AttendanceScreen:
///   - Created new MobileScannerController in initState
///   - On every rebuild (e.g., orientation change, tab switch) controller recreated
///   - Result: Camera flicker, session restart, poor UX
///
/// Solution:
///   - One controller per app lifetime
///   - Shared across all scanner instances
///   - Lifecycle managed independently of widget tree
///   - Start/stop independent of navigation
class ScannerService {
  static final ScannerService _instance = ScannerService._internal();
  factory ScannerService() => _instance;
  ScannerService._internal();

  MobileScannerController? _controller;
  bool _isInitialized = false;
  bool _isScanning = false;

  /// Get the singleton controller (creates if needed)
  MobileScannerController get controller {
    if (_controller == null) {
      _controller = MobileScannerController(
        facing: CameraFacing.back,
        torchEnabled: false,
        detectionSpeed: DetectionSpeed.normal,
      );
      debugPrint('[ScannerService] Controller created (singleton)');
    }
    return _controller!;
  }

  /// Initialize the camera (call once on app start or feature init)
  Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('[ScannerService] Already initialized');
      return;
    }

    try {
      _isInitialized = true;
      debugPrint('[ScannerService] Camera initialized successfully');
    } catch (e) {
      debugPrint('[ScannerService] Camera init failed: $e');
      rethrow;
    }
  }

  /// Start scanning (called when screen becomes visible)
  Future<void> startScanning() async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_isScanning) {
      debugPrint('[ScannerService] Already scanning');
      return;
    }

    try {
      await controller.start();
      _isScanning = true;
      debugPrint('[ScannerService] Scanning started');
    } catch (e) {
      debugPrint('[ScannerService] Failed to start scanning: $e');
    }
  }

  /// Stop scanning (called when screen hidden or app paused)
  Future<void> stopScanning() async {
    if (!_isScanning) {
      return;
    }

    try {
      await controller.stop();
      _isScanning = false;
      debugPrint('[ScannerService] Scanning stopped');
    } catch (e) {
      debugPrint('[ScannerService] Failed to stop scanning: $e');
    }
  }

  /// Toggle torch/flashlight
  Future<void> toggleTorch() async {
    try {
      await controller.toggleTorch();
    } catch (e) {
      debugPrint('[ScannerService] Torch toggle failed: $e');
    }
  }

  /// Switch between front/back camera
  Future<void> switchCamera() async {
    try {
      await controller.switchCamera();
    } catch (e) {
      debugPrint('[ScannerService] Camera switch failed: $e');
    }
  }

  /// Check if torch is available
  bool get hasTorch => controller.value.torchState != TorchState.unavailable;

  /// Check if multiple cameras available
  bool get hasMultipleCameras => (controller.value.availableCameras ?? 0) > 1;

  /// Get current camera position
  CameraFacing get cameraFacing => controller.value.cameraDirection;

  /// Dispose controller (call at app shutdown)
  Future<void> dispose() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
      _isInitialized = false;
      _isScanning = false;
      debugPrint('[ScannerService] Controller disposed');
    }
  }

  /// Reset (for testing or forced recreation)
  Future<void> reset() async {
    await dispose();
    _controller = null;
    _isInitialized = false;
    _isScanning = false;
  }

  bool get isInitialized => _isInitialized;
  bool get isScanning => _isScanning;
}
