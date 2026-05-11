import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Encrypted Database Connection Factory
///
/// Uses SQLCipher via sqlite3 package for AES-256 encryption at rest.
/// Encryption key derived from SecurityService (device-specific + user auth).
class EncryptedDatabaseConnection {
  static const String _dbFileName = 'attendance_encrypted.db';

  /// Open encrypted database connection
  ///
  /// Passphrase must be at least 16 characters for proper encryption
  /// Key derivation: SHA256(userId:deviceId:appSalt)
  static Future<DatabaseConnection> open(String passphrase) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, _dbFileName));
    final escapedPassphrase = passphrase.replaceAll("'", "''");

    return DatabaseConnection(
      NativeDatabase(
        file,
        setup: (db) {
          db.execute("PRAGMA key = '$escapedPassphrase';");
          db.execute('SELECT count(*) FROM sqlite_master;');
        },
      ),
    );
  }
}
