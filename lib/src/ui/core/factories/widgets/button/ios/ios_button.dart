// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/domain/abstract/widgets/ai_button.dart';
import 'package:story_teller/src/ui/themes/styles/text_styles.dart';

class IosAiButton extends StatelessWidget implements AiButton {
  final VoidCallback? clickFunction;
  final bool? isFixedSize;
  final Color? backgroundColor;
  final double? padding;
  final double? height;
  final double? width;
  final double? borderSide;
  final Color? foregroundColor;
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
    this.foregroundColor,
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
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  const Color.fromARGB(255, 108, 108, 108), // Color del borde
              width: 1.0, // Grosor del borde
            ),
            borderRadius: BorderRadius.circular(24.0), // Radio de borde
          ),
          // color: backgroundColor ?? Theme.of(context).buttonTheme.colorScheme!.background,
          child: buttonText(
            text,
          ),
        ),
      ),
    );
  }
}
