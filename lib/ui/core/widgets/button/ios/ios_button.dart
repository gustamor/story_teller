import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/widgets/ai_button.dart';

class IosAiButton extends StatelessWidget implements AiButton {
  final Color? backgroundColor;

  final double? padding;
  final double? height;
  final double? width;
  final String? text;
  final TextStyle? textStyle;

  const IosAiButton({
    super.key,
    this.text,
    this.backgroundColor,
    this.padding,
    this.height,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: CupertinoButton(
        color: backgroundColor,
        child: Text(
          text!,
          style: textStyle!,
        ),
        onPressed: () => {},
      ),
    );
  }
}
