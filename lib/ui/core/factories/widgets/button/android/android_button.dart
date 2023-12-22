// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class AndroidAiButton extends StatelessWidget {
  final VoidCallback? clickFunction;
  final bool? isFixedSize;
  final double? height;
  final double? width;
  final double? borderSide;
  final String text;
  final TextStyle? textStyle;
  final double? padding;
  final Color? backgroundColor;

  const AndroidAiButton({
    super.key,
    this.padding,
    this.backgroundColor,
    this.height,
    this.width,
    required this.text,
    this.textStyle,
    this.clickFunction,
    this.isFixedSize,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              Theme.of(context).buttonTheme.colorScheme!.primary,
          fixedSize: (isFixedSize!) ? Size(width!.w, height!.h) : null,
          shape: RoundedRectangleBorder(
            side: (borderSide != null)
                ? BorderSide(color: Theme.of(context).unselectedWidgetColor, width: borderSide ?? 0)
                : BorderSide.none,
            borderRadius:
                BorderRadius.circular((isFixedSize!) ? height! * 0.5 : 24),
          ),
        ),
        onPressed: clickFunction!,
        child: Text(
          text,
          style: textStyle ?? AndroidStyle.cardCaption,
        ),
      ),
    );
  }
}