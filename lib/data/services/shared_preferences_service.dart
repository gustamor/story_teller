import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_teller/domain/abstract/services/abstract_shared_preferenes_service.dart';

/// Service for managing local preferences using SharedPreferences.
///
/// Implements [AbstractSharedPreferencesService] to provide methods for storing and retrieving
/// various data types (String, double) in local storage.
class SharedPreferencesService implements AbstractSharedPreferencesService {
  
  /// Retrieves a string value from SharedPreferences based on the provided [key].
  ///
  /// Returns the string value associated with the [key]. If the key does not exist, returns an empty string.
  @override
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  /// Saves a string [value] to SharedPreferences associated with the specified [key].
  ///
  /// The [key] is used as an identifier to store the [value]. The value can later be retrieved or updated using the same [key].
  @override
  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Retrieves a double value from SharedPreferences based on the provided [key].
  ///
  /// Returns the double value associated with the [key]. If the key does not exist, returns 0.0.
  @override
  Future<double> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0.0;
  }

  /// Saves a double [value] to SharedPreferences associated with the specified [key].
  ///
  /// The [key] is used as an identifier to store the [value]. The value can later be retrieved or updated using the same [key].
  @override
  Future<void> setDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }
}
