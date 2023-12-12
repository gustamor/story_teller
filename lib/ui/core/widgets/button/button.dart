import 'package:flutter/cupertino.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/widgets/ai_button.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceButton extends StatelessWidget implements AiButton {
  final VoidCallback? clickFunction;
  final Color? backgroundColor;
  final double? padding;
  final double? height;
  final double? width;
  final String? text;
  final TextStyle? textStyle;
  final double? androidPadding;
  final Color? androidBackgroundColor;
  final double? iosPadding;
  final Color? iosBackgroundColor;

  NiceButton({
    super.key,
    this.text,
    this.textStyle,
    this.androidPadding,
    this.androidBackgroundColor,
    this.iosPadding,
    this.iosBackgroundColor,
    this.backgroundColor,
    this.padding = 0.0,
    this.height,
    this.width,
    this.clickFunction,
  });

  final ui = uiFactory();

  @override
  Widget build(BuildContext context) {
    final log = LogImpl();
    log.d("1 button factory impl $clickFunction");

    return ui.createButton(
      clickFunction: clickFunction,
      height: height,
      width: width,
      padding: padding,
      text: text,
      textStyle: textStyle,
      bgColor: backgroundColor,
    );
  }
}
