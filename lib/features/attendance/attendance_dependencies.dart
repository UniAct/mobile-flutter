import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/core/security/security_service.dart';
import 'package:mobile_flutter/core/utils/connection_monitor.dart';
import 'package:mobile_flutter/features/attendance/data/database/attendance_database.dart';
import 'package:mobile_flutter/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/datasources/attendance_remote_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/migration/attendance_migration_service.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/attendance_repository.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/connectivity_repository.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/sync_repository.dart';
import 'package:mobile_flutter/features/attendance/services/local_student_service.dart';
import 'package:mobile_flutter/features/attendance/services/scanner_service.dart';
import 'package:mobile_flutter/features/attendance/services/sync_engine.dart';

/// Singleton container for attendance feature dependencies.
class AttendanceDependencies {
  AttendanceDependencies._(
    this.apiClient,
    this.scannerService,
    this.securityService,
  );

  static final AttendanceDependencies instance = AttendanceDependencies._(
    ApiClient(),
    ScannerService(),
    SecurityService(),
  );

  final ApiClient apiClient;
  final ScannerService scannerService;
  final SecurityService securityService;
  final ConnectionMonitor _connectionMonitor = ConnectionMonitor();

  AttendanceDatabase? _database;
  AttendanceLocalDataSource? _localDataSource;
  AttendanceRemoteDataSource? _remoteDataSource;
  AttendanceRepository? _attendanceRepository;
  SyncRepository? _syncRepository;
  ConnectivityRepository? _connectivityRepository;
  SyncEngine? _syncEngine;
  AttendanceMigrationService? _migrationService;
  LocalStudentService? _localStudentService;

  Future<void>? _initFuture;
  bool _isInitialized = false;
  String? _deviceId;
  String? _userId;

  bool get isReady => _isInitialized;

  AttendanceDatabase get database => _require(_database, 'database');
  AttendanceLocalDataSource get localDataSource =>
      _require(_localDataSource, 'localDataSource');
  AttendanceRemoteDataSource get remoteDataSource =>
      _require(_remoteDataSource, 'remoteDataSource');
  AttendanceRepository get attendanceRepository =>
      _require(_attendanceRepository, 'attendanceRepository');
  SyncRepository get syncRepository =>
      _require(_syncRepository, 'syncRepository');
  ConnectivityRepository get connectivityRepository =>
      _require(_connectivityRepository, 'connectivityRepository');
  SyncEngine get syncEngine => _require(_syncEngine, 'syncEngine');
  AttendanceMigrationService get migrationService =>
      _require(_migrationService, 'migrationService');
  LocalStudentService get localStudentService =>
      _require(_localStudentService, 'localStudentService');

  T _require<T>(T? value, String name) {
    if (value == null) {
      throw StateError(
        '[AttendanceDependencies] "$name" was accessed before initialize() '
        'completed. Always await initialize() before touching any repository '
        'or service.',
      );
    }
    return value;
  }

  Future<void> initialize() {
    if (_isInitialized) {
      return Future.value();
    }

    _initFuture ??= _doInitialize();
    return _initFuture!;
  }

  Future<void> _doInitialize() async {
    try {
      final authToken = await securityService.getAuthToken();
      _userId = await securityService.resolveStableUserIdentity(
        authToken: authToken,
      );
      _deviceId = await securityService.getDeviceId();
      final passphrase = await securityService.getDatabasePassphrase(_userId);

      _database = await AttendanceDatabase.openEncrypted(
        passphrase: passphrase,
      );
      _localDataSource = AttendanceLocalDataSource(database: _database!);
      _remoteDataSource = AttendanceRemoteDataSource(apiClient: apiClient);
      _attendanceRepository = AttendanceRepository(
        localDataSource: _localDataSource!,
        remoteDataSource: _remoteDataSource!,
      );
      _syncRepository = SyncRepository(localDataSource: _localDataSource!);
      _connectivityRepository = ConnectivityRepository(
        monitor: _connectionMonitor,
      );
      _syncEngine = SyncEngine(
        syncRepository: _syncRepository!,
        connectivityRepository: _connectivityRepository!,
        remoteDataSource: _remoteDataSource!,
        localDataSource: _localDataSource!,
      );
      _migrationService = AttendanceMigrationService(
        database: _database!,
        localDataSource: _localDataSource!,
      );
      _localStudentService = LocalStudentService(
        database: _database!,
        deviceId: _deviceId!,
      );

      try {
        await scannerService.initialize();
      } catch (e) {
        debugPrint(
          '[AttendanceDependencies] Scanner init failed (non-fatal): $e',
        );
      }

      await _runMigrationsInBackground();
      _syncEngine!.initialize(enablePeriodicSync: true);
      _isInitialized = true;
      debugPrint('[AttendanceDependencies] Ready.');
    } catch (e, st) {
      _initFuture = null;
      debugPrint('[AttendanceDependencies] Init failed: $e\n$st');
      rethrow;
    }
  }

  Future<void> _runMigrationsInBackground() async {
    await SchedulerBinding.instance.endOfFrame;
    await Future.microtask(() {
      _migrationService!.migrateIfNeeded().catchError((e) {
        debugPrint('[AttendanceDependencies] Migration error (non-fatal): $e');
      });
    });
  }

  Future<int> pendingSyncCount() async {
    if (!_isInitialized || _syncRepository == null) {
      return 0;
    }
    return _syncRepository!.getPendingCount();
  }

  void dispose() {
    try {
      _syncEngine?.dispose();
    } catch (_) {}
    try {
      scannerService.dispose();
    } catch (_) {}
    try {
      _database?.close();
    } catch (_) {}
    try {
      _connectionMonitor.stop();
    } catch (_) {}
  }
}
