import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/services/shared_preferences_service.dart';

/// Provides an instance of [SharedPreferencesService].
///
/// This provider is responsible for creating and managing an instance of `SharedPreferencesService`.
/// It facilitates access to local storage for persisting key-value pairs, typically used for storing
/// simple data such as user preferences or settings. The `SharedPreferencesService` encapsulates
/// the operations related to shared preferences, providing a more convenient and abstracted interface.
final sharedPreferencesProvider = Provider<SharedPreferencesService>((
  ref,
) {
  return SharedPreferencesService();
});
