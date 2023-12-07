import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/widgets/button/ios/ios_button.dart';
import 'package:story_teller/ui/core/widgets/clickable_card/ios/ios_clickable_card.dart';

class IOSFactory implements WidgetFactory {
  @override
  Widget createButton({
    double? padding = 8.0,
    Color? bgColor = const Color(0x00000000),
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return IosAiButton(
      padding: iosPadding ?? padding,
      backgroundColor: iosBackgroundColor ?? bgColor,
    );
  }

  @override
  Widget createClickableCard() {
    return const IosClickableCard();
  }
}
