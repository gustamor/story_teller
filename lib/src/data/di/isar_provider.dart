import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/models/tale.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/models/user.dart';

/// Provides a future that resolves to an instance of [Isar].
///
/// This provider asynchronously initializes and provides access to the Isar database.
/// It retrieves the application's documents directory, a typical location for storing
/// database files, and opens an Isar instance with schemas for `LocalUser` and `Tale`.
/// The `inspector` flag is set to `true`, enabling features for database inspection,
/// useful for development and debugging.
///
/// The `FutureProvider` ensures the database is properly initialized before any access.
/// Error handling is implemented to manage potential initialization issues.
///
/// Usage:
/// Access this provider in the app to ensure the database is ready for use, typically
/// during app startup or when performing database operations.
final isarProvider = FutureProvider<Isar>((
  ref,
) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        LocalUserSchema,
        TaleSchema,
      ],
      directory: dir.path,
      inspector: true,
    );
    return isar;
  } catch (e) {
    // Log the exception only in debug mode
    if (kDebugMode) {
      print(
        'Error initializing Isar database: $e',
      );
    }
    rethrow; // Re-throwing the exception after logging or handling
  }
});
