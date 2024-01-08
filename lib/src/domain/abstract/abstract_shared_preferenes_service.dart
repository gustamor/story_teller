/// Abstract class defining the contract for shared preferences service.
///
/// This class provides an interface for a service that interacts with the application's
/// shared preferences. It includes methods for getting and setting string and double
/// values, allowing for persistent storage of simple data types.
abstract class AbstractSharedPreferencesService {
  /// Retrieves a string value from shared preferences.
  ///
  /// Implementations should return the string value associated with the given [key].
  /// If the key does not exist, this method might return `null` or a default value, as per the implementation.
  Future<String> getString(String key);

  /// Stores a string value in shared preferences.
  ///
  /// Implementations should persist the [value] associated with the given [key].
  /// This method might throw an exception if the storage operation fails.
  Future<void> setString(String key, String value);

  /// Retrieves a double value from shared preferences.
  ///
  /// Implementations should return the double value associated with the given [key].
  /// Similar to `getString`, if the key does not exist, this method might return `null` or a default value.
  Future<double> getDouble(String key);

  /// Stores a double value in shared preferences.
  ///
  /// Implementations should persist the [value] associated with the given [key].
  /// Like `setString`, this method might throw an exception in case of a failure in the storage operation.
  Future<void> setDouble(String key, double value);
}
