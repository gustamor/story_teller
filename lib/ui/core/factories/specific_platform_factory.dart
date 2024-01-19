import 'dart:io' show Platform;

import 'package:story_teller/domain/factories/abstract_widgets_factory.dart';
import 'package:story_teller/ui/core/factories/android_factory_impl.dart';
import 'package:story_teller/ui/core/factories/ios_factory_impl.dart';

/// Selects a specific platform widget factory based on the current platform.
///
/// This function checks the current platform and returns an instance of [AbstractWidgetFactory]
/// that corresponds to the platform. If the platform is iOS, it returns an instance of [IOSFactory].
/// For Android or any other platform, it returns an instance of [AndroidFactory].
///
/// In case of any exception (e.g., platform detection fails), it defaults to [AndroidFactory].
///
/// - Returns:
///   An instance of [AbstractWidgetFactory] specific to the current platform.
AbstractWidgetFactory selectSpecificPlatformWidgetFactory() {
  late AbstractWidgetFactory factory;
  
  try {
    if (Platform.isIOS) {
      // Use iOS specific widget factory
      factory = IOSFactory();
    } else if (Platform.isAndroid) {
      // Use Android specific widget factory
      factory = AndroidFactory();
    } else {
      // Default to Android factory for other platforms
      factory = AndroidFactory();
    }
  } catch (e) {
    // In case of any exception, default to Android factory
    factory = AndroidFactory();
  }

  return factory;
}
