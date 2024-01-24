// ignore_for_file: unused_import

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/abstract/services/abstract_remote_config_service.dart';
import 'package:story_teller/domain/abstract/services/abstract_tell_logger.dart';

/// Service for managing and initializing Firebase Remote Config.
///
/// Implements [AbstractFirebaseRemoteConfigService] to provide functionalities for
/// configuring and initializing Firebase Remote Config. It handles setting up default
/// values and fetch intervals, and activates fetched configurations.
class RemoteConfigService implements AbstractFirebaseRemoteConfigService {
  final Ref ref;

  /// Constructor for [RemoteConfigService].
  ///
  /// Requires a [Ref] object to access other providers, such as the Firebase Remote Config provider.
  /// ```dart
  /// final remoteConfigService = RemoteConfigService(ref);
  /// ```
  RemoteConfigService(this.ref);

  @override

  /// Asynchronously initializes the Firebase Remote Config.
  ///
  /// Configures the Remote Config settings such as fetch timeout and minimum fetch interval.
  /// Also sets default values for the Remote Config parameters and fetches and activates
  /// the latest remote configurations. Errors during initialization are logged and rethrown.
  ///
  /// Example:
  /// ```dart
  /// await remoteConfigService.initRemoteConfig();
  /// ```
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
            await remoteConfig.fetchAndActivate();


    } catch (e) {
   //   print("AAA $e");
      // Error handling code...
    }
  }

  @override

  /// Retrieves a string value from Firebase Remote Config based on the provided [key].
  ///
  /// Example:
  /// ```dart
  /// final welcomeMessage = await remoteConfigService.getStringValue('welcome_message');
  /// print(welcomeMessage); // Outputs: Welcome to our app!
  /// ```
  Future<String> getStringValue(String key) async {
    final remoteConfig = ref.watch(firebaseRemoteConfigProvider);
    return remoteConfig.getString(key);
  }

  @override

  /// Retrieves a boolean value from Firebase Remote Config based on the provided [key].
  ///
  /// Note: This method is not implemented yet and will throw [UnimplementedError] if used.
  /// Example usage (not implemented):
  /// ```dart
  /// // Throws UnimplementedError
  /// final featureEnabled = await remoteConfigService.getBoolValue('feature_enabled');
  /// ```
  Future<bool> getBoolValue(String key) {
    throw UnimplementedError();
  }

  @override

  /// Retrieves a numerical value from Firebase Remote Config based on the provided [key].
  ///
  /// Example:
  /// ```dart
  /// final maxItemCount = await remoteConfigService.getIntValue('max_item_count');
  /// print(maxItemCount); // Outputs: e.g., 100
  /// ```
  Future<int> getIntValue(String key) async {
    final remoteConfig = ref.watch(firebaseRemoteConfigProvider);
    return remoteConfig.getInt(key);
  }
}
