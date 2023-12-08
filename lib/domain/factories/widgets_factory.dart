import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WidgetFactory {
  Widget createButton(
      {double? padding,
      Color? bgColor,
      Color? iosBackgroundColor,
      Color? androidBackgroundColor,
      double? iosPadding,
      double? androidPadding});

  Widget createClickableCard({
    double? height,
    double? width,
    String? caption,
    String? description,
    TextStyle? textStyle,
    Color? bgColor,
    Color? androidBackgroundColor,
    Color? iosBackgroundColor,
    Color? surfaceTintColor,
    Color? shadowColor,
    Color? androidShadowColor,
    double? elevation,
    double? androidElevation,
    ShapeBorder? shape,
    EdgeInsetsGeometry? margin,
    Clip? clipBehavior,
    String? decorImage,
    double? borderRadius,
    BoxFit? fit,
    Widget? child,
  });

  Widget navigationAppBar({
    String? title,
    String? leftIcon,
    String? rightIcon,
    Function? leftTapFunction,
    Function? rightTapFunction,
  });

  Widget navigationBottomBar({
    String? id
});

}
