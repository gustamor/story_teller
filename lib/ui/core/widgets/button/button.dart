
import 'package:flutter/cupertino.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceButton extends StatelessWidget {
  NiceButton({
    super.key,
    this.androidPadding,
    this.androidBackgroundColor,
    this.iosPadding,
    this.iosBackgroundColor,
    this.backgroundColor = const Color(
      0x00000000,
    ),
    this.padding = 0.0,
  });

  final Color? backgroundColor;
  final double? padding;
  final double? androidPadding;
  final Color? androidBackgroundColor;
  final double? iosPadding;
  final Color? iosBackgroundColor;

  final ui = uiFactory();

  @override
  Widget build(BuildContext context) {
    return ui.createButton(
      padding: padding,
      bgColor: backgroundColor,
      iosPadding: iosPadding,
      iosBackgroundColor: iosBackgroundColor,
      androidBackgroundColor: androidBackgroundColor,
      androidPadding: androidPadding,
    );
  }
}
