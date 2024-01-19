import 'package:flutter/widgets.dart';

/// Represents an abstract clickable card with customizable properties.
///
/// This abstract class provides a structure for clickable cards, allowing
/// consistent styling and behavior customization. It is designed to support
/// platform-specific customizations for different platforms like Android and iOS.
abstract class AbstractAiClickableCard {
  /// Gets the height of the card.
  double? get height;

  /// Gets the width of the card.
  double? get width;

  /// Gets the caption text of the card.
  String? get caption;

  /// Gets the description text of the card.
  String? get description;

  /// Gets the style for the caption and description text.
  TextStyle? get textStyle;

  /// Gets the background color of the card.
  Color? get bgColor;

  /// Gets the background color used in Android-specific styling of the card.
  Color? get androidBackgroundColor;

  /// Gets the background color used in iOS-specific styling of the card.
  Color? get iosBackgroundColor;

  /// Gets the tint color applied to the surface of the card.
  Color? get surfaceTintColor;

  /// Gets the color of the shadow cast by the card.
  Color? get shadowColor;

  /// Gets the color of the shadow cast by the card in Android-specific styling.
  Color? get androidShadowColor;

  /// Gets the elevation of the card (depth effect).
  double? get elevation;

  /// Gets the elevation of the card in Android-specific styling.
  double? get androidElevation;

  /// Gets the shape of the card's border.
  ShapeBorder? get shape;

  /// Gets the margin around the card.
  EdgeInsetsGeometry? get margin;

  /// Gets the clipping behavior for the card.
  Clip? get clipBehavior;

  /// Gets the path or URL of the decorative image on the card.
  String? get decorImage;

  /// Gets the border radius of the card.
  double? get borderRadius;

  /// Gets how the card's content should be inscribed into the available space.
  BoxFit? get fit;

  /// Gets the function to execute when the card is tapped.
  VoidCallback get clickFunction;

  /// Gets the optional child widget to display inside the card.
  Widget? get child;
}
