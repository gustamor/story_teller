import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_button.dart';

class IosAiButton extends StatelessWidget implements AiButton {
  final VoidCallback? clickFunction;
  final bool? isFixedSize;
  final Color? backgroundColor;
  final double? padding;
  final double? height;
  final double? width;
  final double? borderSide;

  final String text;
  final TextStyle? textStyle;

  const IosAiButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.padding,
    this.height,
    this.width,
    this.textStyle,
    this.clickFunction,
    this.isFixedSize,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: CupertinoButton(
        
        borderRadius: BorderRadius.all(
          Radius.circular(
            30.r,
          ),
        ),
        color: CupertinoColors.activeBlue,
        onPressed: clickFunction!,
        child: Text(
          text,
          style: textStyle!,
        ),
      ),
    );
  }
}
