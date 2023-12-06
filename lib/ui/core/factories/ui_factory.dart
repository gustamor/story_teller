import 'dart:io' show Platform;

import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/factories/android_factory_impl.dart';
import 'package:story_teller/ui/core/factories/ios_factory_impl.dart';

WidgetFactory uiFactory() {
  late WidgetFactory factory;
  if (Platform.isIOS) {
    factory = IOSFactory();
  } else if (Platform.isAndroid) {
    factory = AndroidFactory();
  } else {
    factory = AndroidFactory();
  }
  return factory;
}
