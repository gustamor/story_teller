import 'dart:io' show Platform;

import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/data/factories/android_factory_impl.dart';
import 'package:story_teller/data/factories/ios_factory_impl.dart';

WidgetFactory uiFactory() {
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
