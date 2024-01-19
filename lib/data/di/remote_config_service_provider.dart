import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/fire_remote_config_service.dart';

/// Provides an initialized instance of [RemoteConfigService].
///
/// Responsible for setting up and providing a fully initialized [RemoteConfigService]. It
/// ensures that Firebase Remote Config is properly configured and ready to use before the
/// service is utilized in the application. The initialization is performed asynchronously.
final remoteConfigProvider = FutureProvider<RemoteConfigService>((ref) async {
  // Create an instance of RemoteConfigService
  final remoteConfigService = RemoteConfigService(ref);

  // Await the initialization of Firebase Remote Config settings
  await remoteConfigService.initRemoteConfig();

  // Return the initialized RemoteConfigService
  return remoteConfigService;
});
