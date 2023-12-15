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
  });

  @override
  Widget build(BuildContext context) {
    final log = LogImpl();

    return Padding(
      padding: EdgeInsets.all(padding!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).buttonTheme.colorScheme!.primary,
          fixedSize: (isFixedSize!) ?  Size(width!.w, height!.h) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height! * 0.5),
          ),
        ),
        onPressed: clickFunction!,
        child: Text(
          text,
          style: textStyle!,
        ),
      ),
    );
  }
}
