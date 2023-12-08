import 'package:flutter/material.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/widgets/app_bar/android/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/button/android/android_button.dart';
import 'package:story_teller/ui/core/widgets/clickable_card/android/android_clickable_card.dart';

import '../widgets/bottom_bar/android/navigation_bottom_bar.dart';

class AndroidFactory implements WidgetFactory {
  @override
  Widget createButton({
    double? padding = 0.0,
    Color? bgColor = const Color(0x00000000),
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return AndroidAiButton(
      padding: androidPadding ?? padding,
      androidBackgroundColor: androidBackgroundColor ?? bgColor,
    );
  }

  @override
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
  }) {
    return AndroidAiClickableCard(
        caption: caption,
        description: description,
        decorImage: decorImage,
        height: height,
        width: width,
        borderRadius: borderRadius);
  }

  @override
  Widget navigationAppBar({
    String? title,
    String? leftIcon,
    String? rightIcon,
    Function? leftTapFunction,
    Function? rightTapFunction,
  }) {
    return AndroidNavigationAppBar(
        title: title ?? "",
        leftIcon: leftIcon ?? "",
        rightIcon: rightIcon ?? "",
        leftTapFunction: leftTapFunction ?? () => {},
        rightTapFunction: rightTapFunction ?? () => {});
  }

  @override
  Widget navigationBottomBar({String? id}) {
    return const AndroidAiBottomBar();
  }
}
