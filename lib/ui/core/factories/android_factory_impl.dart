import 'package:flutter/material.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/widgets/android/android_clickable_card.dart';
import 'package:story_teller/ui/core/widgets/clickable_card/android/android_button.dart';

class AndroidFactory implements WidgetFactory {
  @override
  Widget createButton({
    double? padding = 0.0,
    Color? bgColor = const Color(0x00000000),
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return AndroidAiButton(
      padding: androidPadding ?? padding,
      androidBackgroundColor: androidBackgroundColor ?? bgColor,
    );
  }

  @override
  Widget createClickableCard() {
    return const AndroidClickableCard();
  }
}
