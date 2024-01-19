import 'package:flutter/widgets.dart';

/// Represents an abstract button with AI capabilities.
///
/// This abstract class defines a structure for buttons with customizable
/// properties. It is designed to be platform-agnostic with support for
/// specific customizations for different platforms (like Android and iOS).
abstract class AbstractAiButton {
  
  /// Gets the function to execute when the button is tapped.
  VoidCallback get clickFunction;

  /// Determines if the button has a fixed size.
  bool? get isFixedSize;

  /// Gets the background color of the button.
  Color? get backgroundColor;

  /// Gets the foreground color (usually the color of the text or icon) of the button.
  Color? get foregroundColor;

  /// Gets the padding around the button's content.
  double? get padding;

  /// Gets the height of the button.
  double? get height;

  /// Gets the width of the button.
  double? get width;

  /// Gets the width of the border surrounding the button.
  double? get borderSide;

  /// Gets the text displayed on the button.
  String get text;

  /// Gets the style of the text displayed on the button.
  TextStyle? get textStyle;

  /// Gets the padding used in Android-specific styling of the button.
  double? get androidPadding;

  /// Gets the padding used in iOS-specific styling of the button.
  double? get iosPadding;

  /// Gets the background color used in Android-specific styling of the button.
  Color? get androidBackgroundColor;

  /// Gets the background color used in iOS-specific styling of the button.
  Color? get iosBackgroundColor;
}
