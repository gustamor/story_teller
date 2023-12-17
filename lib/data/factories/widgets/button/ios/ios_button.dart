import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_button.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

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
            16.r,
          ),
        ),
        onPressed: clickFunction!,
        child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 108, 108, 108), // Color del borde
                width: 1.0, // Grosor del borde
              ),
              borderRadius: BorderRadius.circular(24.0), // Radio de borde
            ),
            child: Text(
            text,
            style: textStyle ?? IosStyle.cardDescription,
          ),
        ),
      ),
    );
  }
}
