import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/widgets/ai_button.dart';

class IosAiButton extends StatelessWidget implements AiButton {
  final Color? androidBackgroundColor;
  final double? androidPadding;
  final Color? backgroundColor;
  final Color? iosBackgroundColor;
  final double? iosPadding;
  final double? padding;

  const IosAiButton({
    super.key,
    this.androidBackgroundColor,
    this.androidPadding,
    this.backgroundColor,
    this.iosBackgroundColor,
    this.iosPadding,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: CupertinoButton(
        color: iosBackgroundColor ?? backgroundColor,
        child: const Text("Cupertino Button"),
        onPressed: () => {},
      ),
    );
  }
}
