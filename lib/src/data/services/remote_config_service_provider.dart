import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/services/fire_remote_config_service.dart';

/// Provides an initialized instance of [RemoteConfigService].
///
/// This provider is responsible for creating and initializing [RemoteConfigService], ensuring
/// that Firebase Remote Config is set up before the service is used elsewhere in the application.
/// It asynchronously waits for the initialization process to complete before providing the service instance.
final remoteConfigProvider = FutureProvider<RemoteConfigService>((ref) async {
  // Create an instance of RemoteConfigService
  final remoteConfigService = RemoteConfigService(ref);

  // Await the initialization of Firebase Remote Config settings
  await remoteConfigService.initRemoteConfig();

  // Return the initialized RemoteConfigService
  return remoteConfigService;
});