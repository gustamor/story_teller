

/// An abstract class that defines the interface for a Firebase Remote Config service.
///
/// This service is responsible for initializing remote configurations and providing
/// methods to fetch configuration values based on a given key.
abstract class AbstractFirebaseRemoteConfigService {
  /// Initializes the remote configuration.
  ///
  /// It should be called before attempting to fetch any configuration values. This method
  /// typically ensures that the latest configuration values are fetched and available for use.
  Future<void> initRemoteConfig();

  /// Retrieves a string value for the given configuration [key].
  ///
  /// [key] : The key for which the string value is to be fetched.
  /// Returns the string value associated with the [key]. If the key does not exist or
  /// is not a string, the behavior is implementation-dependent.
  Future<String> getStringValue(String key);

  /// Retrieves a number value for the given configuration [key].
  ///
  /// [key] : The key for which the number value is to be fetched.
  /// Returns the number value associated with the [key]. If the key does not exist or
  /// is not a number, the behavior is implementation-dependent.
  Future<String> getNumberValue(String key);

  /// Retrieves a boolean value for the given configuration [key].
  ///
  /// [key] : The key for which the boolean value is to be fetched.
  /// Returns the boolean value associated with the [key]. If the key does not exist or
  /// is not a boolean, the behavior is implementation-dependent.
  Future<String> getBoolValue(String key);
}
