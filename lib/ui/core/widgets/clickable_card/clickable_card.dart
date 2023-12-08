import 'dart:core';

import 'package:flutter/material.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceClickableCard extends StatelessWidget {
  final double? height;
  final double? width;
  final String? caption;
  final String? description;
  final TextStyle? textStyle;
  final Color? bgColor;
  final Color? androidBackgroundColor;
  final Color? iosBackgroundColor;
  final Color? surfaceTintColor;
  final Color? shadowColor;
  final Color? androidShadowColor;
  final double? elevation;
  final double? androidElevation;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;
  final String? decorImage;
  final double? borderRadius;
  final BoxFit? fit;
  final Widget? child;

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
  });

  final ui = uiFactory();

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
        borderRadius: borderRadius);
  }
}
