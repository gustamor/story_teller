// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_button.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

/// A button component tailored for iOS platforms, adhering to Cupertino design guidelines.
///
/// This class provides a customizable button with various properties like size, text,
/// padding, colors, and click behavior. It implements [AbstractAiButton] for consistency
/// across different platform-specific button implementations.
class IosAiButton extends StatelessWidget implements AbstractAiButton {
  @override
  final VoidCallback clickFunction;
  @override
  final bool? isFixedSize;
  @override
  final Color? backgroundColor;
  @override
  final double? padding;
  @override
  final double? height;
  @override
  final double? width;
  @override
  final double? borderSide;
  @override
  final Color? foregroundColor;
  @override
  final String text;
  @override
  final TextStyle? textStyle;
  @override
  final Color? iosBackgroundColor;
  @override
  final double? iosPadding;

  /// Constructs an [IosAiButton].
  ///
  /// - Parameters:
  ///   - `text`: Text to display on the button.
  ///   - `backgroundColor`: Background color of the button. Falls back to `iosBackgroundColor` if provided.
  ///   - `padding`: Padding inside the button. Falls back to `iosPadding` if provided.
  ///   - `height`: Height of the button.
  ///   - `width`: Width of the button.
  ///   - `textStyle`: Text style for the button text.
  ///   - `clickFunction`: Function to execute when the button is tapped.
  ///   - `isFixedSize`: Determines if the button has a fixed size.
  ///   - `borderSide`: Width of the border surrounding the button.
  ///   - `foregroundColor`: Foreground color (usually the color of the text or icon) of the button.
  ///   - `iosBackgroundColor`: Background color specific to iOS styling. Overrides `backgroundColor` if provided.
  ///   - `iosPadding`: Padding inside the button specific to iOS styling. Overrides `padding` if provided.
  const IosAiButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.padding,
    this.height,
    this.width,
    this.textStyle,
    required this.clickFunction,
    this.isFixedSize,
    this.borderSide,
    this.foregroundColor,
    this.iosBackgroundColor,
    this.iosPadding,
  });

  @override
  Widget build(BuildContext context) {
    // Constructs the UI of the iOS styled button
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: CupertinoButton(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        onPressed: clickFunction,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 108, 108, 108), // Border color
              width: 1.0, // Border thickness
            ),
            borderRadius: BorderRadius.circular(24.0), // Border radius
          ),
          child: buttonText(text),
        ),
      ),
    );
  }

  @override
  Color? get androidBackgroundColor => throw UnimplementedError();

  @override
  double? get androidPadding => throw UnimplementedError();

  // Constructs the text widget for the button
  Widget buttonText(String text) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
