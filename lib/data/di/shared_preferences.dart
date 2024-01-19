import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/shared_preferences_service.dart';

/// Provides an instance of [SharedPreferencesService].
///
/// Manages access to local storage for persisting key-value pairs, commonly used for storing user preferences
/// or settings. [SharedPreferencesService] abstracts the operations related to shared preferences, offering a
/// simplified and more convenient interface for local data storage.
final sharedPreferencesProvider = Provider<SharedPreferencesService>((
  ref,
) {
  return SharedPreferencesService();
});
