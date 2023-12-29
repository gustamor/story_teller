import 'dart:io' show Platform;

import 'package:story_teller/domain/factories/abstract_widgets_factory.dart';
import 'package:story_teller/ui/core/factories/android_factory_impl.dart';
import 'package:story_teller/ui/core/factories/ios_factory_impl.dart';

WidgetFactory selectSpecificPlatformWidgetFactory() {
  late WidgetFactory factory;
  try {
    if (Platform.isIOS) {
      factory = IOSFactory();
    } else if (Platform.isAndroid) {
      factory = AndroidFactory();
    } else {
      factory = AndroidFactory();
    }
  } catch (e){
    factory = AndroidFactory();
  }
  return factory;
}
