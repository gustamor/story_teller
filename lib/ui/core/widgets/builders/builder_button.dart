// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';

/// A customizable button widget that adapts its appearance based on the platform (Android or iOS).
///
/// This button can be customized with various properties such as text, colors, dimensions, and padding. 
/// It uses a platform-specific widget factory to create a button that conforms to the design guidelines of the target platform.
class NiceButton extends StatelessWidget {
  /// The function to call when the button is pressed.
  final VoidCallback clickFunction;
  
  /// Indicates if the button should have a fixed size or be sized according to its content.
  final bool? isFixedSize;
  
  /// The background color of the button.
  final Color? backgroundColor;
  
  /// The color of the button's text and icon.
  final Color? foregroundColor;
  
  /// The padding around the button's content.
  final double? padding;
  
  /// The height of the button.
  final double? height;
  
  /// The width of the button.
  final double? width;
  
  /// The width of the button's border.
  final double? borderSide;
  
  /// The text to display inside the button.
  final String text;
  
  /// The style to use for the button's text.
  final TextStyle? textStyle;
  
  /// The padding to use for the button when the platform is Android.
  final double? androidPadding;
  
  /// The background color to use for the button when the platform is Android.
  final Color? androidBackgroundColor;
  
  /// The padding to use for the button when the platform is iOS.
  final double? iosPadding;
  
  /// The background color to use for the button when the platform is iOS.
  final Color? iosBackgroundColor;

  /// Constructs a [NiceButton] with the given properties.
  ///
  /// Initializes the button with customizable attributes for appearance and behavior. Platform-specific
  /// properties (Android and iOS) allow for further customization based on the target platform.
  NiceButton({
    super.key,
    required this.text,
    this.textStyle,
    this.androidPadding,
    this.androidBackgroundColor,
    this.iosPadding,
    this.iosBackgroundColor,
    this.backgroundColor,
    this.foregroundColor,
    this.padding = 0.0,
    this.height,
    this.width,
    required this.clickFunction,
    this.isFixedSize,
    this.borderSide,
  });

  /// A utility for selecting the appropriate widget factory based on the platform.
  final ui = selectSpecificPlatformWidgetFactory();

  /// Builds the visual structure of the button widget.
  ///
  /// Constructs the button using a platform-specific widget factory, ensuring the button adheres to
  /// the design language of the target platform (Android or iOS).
  @override
  Widget build(BuildContext context) {
    return ui.createButton(
      clickFunction: clickFunction,
      isFixedSize: isFixedSize,
      height: height,
      width: width,
      borderSide: borderSide,
      padding: padding,
      text: text,
      textStyle: textStyle,
      bgColor: backgroundColor,
      foregroundColor: foregroundColor,
      androidBackgroundColor: androidBackgroundColor,
      iosBackgroundColor: iosBackgroundColor,
    );
  }
}
