// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_button.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

/// A button component tailored for Android platforms, adhering to Material Design guidelines.
///
/// This class provides a customizable button with various properties like size, text,
/// padding, colors, and click behavior. It implements [AbstractAiButton] for consistency
/// across different platform-specific button implementations.
class AndroidAiButton extends StatelessWidget implements AbstractAiButton {
  @override
  final VoidCallback clickFunction;
  @override
  final bool? isFixedSize;
  @override
  final double? height;
  @override
  final double? width;
  @override
  final double? borderSide;
  @override
  final String text;
  @override
  final TextStyle? textStyle;
  @override
  final double? padding;
  @override
  final Color? backgroundColor;
  @override
  final Color? foregroundColor;
  @override
  final Color? androidBackgroundColor;
  @override
  final double? androidPadding;

  /// Constructs an [AndroidAiButton].
  ///
  /// - Parameters:
  ///   - `clickFunction`: Function to execute when the button is tapped.
  ///   - `isFixedSize`: Determines if the button has a fixed size.
  ///   - `height`: Height of the button.
  ///   - `width`: Width of the button.
  ///   - `borderSide`: Width of the border surrounding the button.
  ///   - `text`: Text to display on the button.
  ///   - `textStyle`: Text style for the button text.
  ///   - `padding`: Padding inside the button.
  ///   - `backgroundColor`: Background color of the button.
  ///   - `foregroundColor`: Foreground color (usually the color of the text or icon) of the button.
  ///   - `androidBackgroundColor`: Background color specific to Android styling. Overrides `backgroundColor` if provided.
  ///   - `androidPadding`: Padding inside the button specific to Android styling. Overrides `padding` if provided.
  const AndroidAiButton({
    super.key,
    this.padding,
    this.backgroundColor,
    this.height,
    this.width,
    required this.text,
    this.textStyle,
    required this.clickFunction,
    this.isFixedSize,
    this.borderSide,
    this.foregroundColor,
    this.androidBackgroundColor,
    this.androidPadding,
  });

  @override
  Widget build(BuildContext context) {
    // Constructs the UI of the Android styled button
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3.r,
          foregroundColor: foregroundColor ??
              Theme.of(context).buttonTheme.colorScheme!.onBackground,
          backgroundColor: backgroundColor ??
              Theme.of(context).buttonTheme.colorScheme!.background,
          fixedSize: (isFixedSize!) ? Size(width!.w, height!.h) : null,
          shape: RoundedRectangleBorder(
            side: (borderSide != null)
                ? BorderSide(
                    color: Theme.of(context).unselectedWidgetColor,
                    width: borderSide ?? 0)
                : BorderSide.none,
            borderRadius:
                BorderRadius.circular((isFixedSize!) ? height! * 0.5 : 24),
          ),
        ),
        onPressed: clickFunction,
        child: buttonText(
          text,
        ),
      ),
    );
  }

  @override
  Color? get iosBackgroundColor => throw UnimplementedError();
  
  @override
  double? get iosPadding => throw UnimplementedError();
  
  // Constructs the text widget for the button
  Widget buttonText(String text) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
