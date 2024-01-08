import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/domain/services/abstract_remote_config_service.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';

/// Service for managing and initializing Firebase Remote Config.
///
/// Implements [AbstractFirebaseRemoteConfigService] to provide functionalities for
/// configuring and initializing Firebase Remote Config. It handles setting up default
/// values and fetch intervals, and activates fetched configurations.
class RemoteConfigService implements AbstractFirebaseRemoteConfigService {
  final Ref ref;

  /// Logger for recording events and errors.
  TellLogger log = LogImpl();

  /// Constructor for [RemoteConfigService].
  ///
  /// Requires a [Ref] object to access other providers, such as the Firebase Remote Config provider.
  RemoteConfigService(this.ref);

  @override
  /// Asynchronously initializes the Firebase Remote Config.
  ///
  /// Configures the Remote Config settings such as fetch timeout and minimum fetch interval.
  /// Also sets default values for the Remote Config parameters and fetches and activates 
  /// the latest remote configurations. Errors during initialization are logged and rethrown.
  Future<void> initRemoteConfig() async {
    final remoteConfig = ref.watch(firebaseRemoteConfigProvider);
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 2),
        minimumFetchInterval: const Duration(minutes: 5),
      ));

      // Define and set default values for the remote config parameters
      await remoteConfig.setDefaults(const {
        // Example: "welcome_message": "Welcome to our app!"
        // Define other key-value pairs as needed
      });

      // Fetch and activate the latest remote configurations
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      log.e("Failed to initialize Firebase Remote Config: $e");
      throw Exception('Failed to initialize Firebase Remote Config: $e');
    }
  }
  
  @override
  Future<String> getStringValue(String key) async {
    final remoteConfig = ref.watch(firebaseRemoteConfigProvider);
    return remoteConfig.getString(key);
  }
  
  @override
  Future<String> getBoolValue(String key) {
    // TODO: implement getBoolValue
    throw UnimplementedError();
  }

  @override
  Future<String> getNumberValue(String key) {
    // TODO: implement getNumberValue
    throw UnimplementedError();
  }
}
