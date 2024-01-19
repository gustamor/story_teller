import 'dart:core';
import 'package:flutter/material.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';

/// A customizable clickable card widget that adapts its appearance based on the platform (Android or iOS).
///
/// This widget can be customized with various properties such as text, colors, dimensions, and padding. 
/// It uses a platform-specific widget factory to create a clickable card that conforms to the design guidelines of the target platform.
class NiceClickableCard extends StatelessWidget {
  /// The height of the card.
  final double? height;

  /// The width of the card.
  final double? width;

  /// The caption text displayed on the card.
  final String? caption;

  /// The description text displayed beneath the caption.
  final String? description;

  /// The style to use for text within the card.
  final TextStyle? textStyle;

  /// The background color of the card.
  final Color? bgColor;

  /// The background color to use for the card when the platform is Android.
  final Color? androidBackgroundColor;

  /// The background color to use for the card when the platform is iOS.
  final Color? iosBackgroundColor;

  /// The color of the material's surface tint.
  final Color? surfaceTintColor;

  /// The color of the shadow cast by the card.
  final Color? shadowColor;

  /// The color of the shadow cast by the card specific to Android styling.
  final Color? androidShadowColor;

  /// The z-coordinate at which to place the card. This controls the size of the shadow below the card.
  final double? elevation;

  /// The elevation shadow depth specific to Android styling.
  final double? androidElevation;

  /// The shape of the card's material.
  final ShapeBorder? shape;

  /// Empty space to surround the card.
  final EdgeInsetsGeometry? margin;

  /// The behavior when a clip is applied to the card.
  final Clip? clipBehavior;

  /// The image to display on the card, typically an asset path.
  final String? decorImage;

  /// The border radius of the card.
  final double? borderRadius;

  /// Specifies how the image should be inscribed into the available space.
  final BoxFit? fit;

  /// The function to call when the card is pressed.
  final VoidCallback clickFunction;

  /// An optional widget to display within the card, typically used for content that isn't just text.
  final Widget? child;

  /// Constructs a [NiceClickableCard] with the given properties.
  ///
  /// Initializes the card with customizable attributes for appearance and behavior. Platform-specific
  /// properties (Android and iOS) allow for further customization based on the target platform.
  NiceClickableCard({
    super.key,
    this.height,
    this.width,
    this.caption,
    this.description,
    this.textStyle,
    this.bgColor = const Color(0x00000000),
    this.androidBackgroundColor,
    this.iosBackgroundColor,
    this.surfaceTintColor,
    this.shadowColor,
    this.androidShadowColor,
    this.elevation,
    this.androidElevation,
    this.shape,
    this.margin,
    this.clipBehavior,
    this.decorImage,
    this.borderRadius = 16.0,
    this.fit = BoxFit.fill,
    this.child,
    required this.clickFunction,
  });

  /// A utility for selecting the appropriate widget factory based on the platform.
  final ui = selectSpecificPlatformWidgetFactory();

  /// Builds the visual structure of the clickable card widget.
  ///
  /// Constructs the clickable card using a platform-specific widget factory, ensuring the card adheres to
  /// the design language of the target platform (Android or iOS).
  @override
  Widget build(BuildContext context) {
    return ui.createClickableCard(
      height: height,
      width: width,
      caption: caption,
      description: description,
      decorImage: decorImage,
      fit: fit,
      bgColor: bgColor,
      androidBackgroundColor: androidBackgroundColor,
      iosBackgroundColor: iosBackgroundColor,
      androidElevation: androidElevation,
      borderRadius: borderRadius,
      clickFunction: clickFunction,
    );
  }
}
