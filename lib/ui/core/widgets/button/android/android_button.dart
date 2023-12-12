// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class AndroidAiButton extends StatelessWidget {
  final VoidCallback? clickFunction;
  final double? height;
  final double? width;
  final String? text;
  final TextStyle? textStyle;
  final double? padding;
  final Color? backgroundColor;

  const AndroidAiButton({
    super.key,
    this.padding,
    this.backgroundColor,
    this.height,
    this.width,
    this.text,
    this.textStyle,
    this.clickFunction,
  });

  @override
  Widget build(BuildContext context) {
    final log = LogImpl();

    log.d("3 android button $clickFunction");
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width!.w, height!.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height! * 0.5),
          ),
        ),
        onPressed: clickFunction!,
        child: Text(
          text!,
          style: textStyle!,
        ),
      ),
    );
  }
}
