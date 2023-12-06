import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/widgets/ios/ios_button.dart';
import 'package:story_teller/ui/core/widgets/ios/ios_clickable_card.dart';

class IOSFactory implements WidgetFactory {
  @override
  Widget createButton({double? padding, Color? bgColor, int? a, int? b}) {
    return IosButton(
      padding: padding ?? 0.0,
      bgColor: bgColor ?? const Color(0xFF0000FF),
    );
  }

  @override
  Widget createClickableCard() {
    return const IosClickableCard();
  }
}
