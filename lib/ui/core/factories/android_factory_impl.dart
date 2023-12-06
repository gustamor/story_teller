import 'package:flutter/material.dart';
import 'package:story_teller/ui/core/widgets/android/android_button.dart';
import 'package:story_teller/ui/core/widgets/android/android_clickable_card.dart';

import '../../../domain/factories/widgets_factory.dart';

class AndroidFactory implements WidgetFactory {
  @override
  Widget createButton({double? padding, Color? bgColor, int? a, int? b}) {
    return AndroidButton(
      padding: padding ?? 0.0,
      color: bgColor ?? Colors.red,
    );
  }

  @override
  Widget createClickableCard() {
    return const AndroidClickableCard();
  }
}
