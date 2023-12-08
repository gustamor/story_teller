// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/widgets/app_bar/ios/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/bottom_bar/ios/navigation_bottom_bar.dart';
import 'package:story_teller/ui/core/widgets/button/ios/ios_button.dart';
import 'package:story_teller/ui/core/widgets/clickable_card/ios/ios_clickable_card.dart';
import 'package:story_teller/domain/widgets/ai_navigation_bar.dart';

class IOSFactory implements WidgetFactory {
  @override
  Widget createButton({
    double? padding = 8.0,
    Color? bgColor = const Color(0x00000000),
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return IosAiButton(
      padding: iosPadding ?? padding,
      backgroundColor: iosBackgroundColor ?? bgColor,
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
    BoxFit? fit,
    double? borderRadius,
    Widget? child,
  }) {
    return IosClickableCard(
      height: height,
      width: width,
      caption: caption,
      description: description,
      decorImage: decorImage,
      fit: fit,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget navigationAppBar({
    String? title,
    String? leftIcon,
    String? rightIcon,
    Function? leftTapFunction,
    Function? rightTapFunction,
  }) {
    return IosNavigationAppBar(
        title: title ?? "",
        leftIcon: leftIcon ?? "",
        rightIcon: rightIcon ?? "",
        leftTapFunction: leftTapFunction ?? () => {},
        rightTapFunction: rightTapFunction ?? () => {});
  }

  @override
  Widget navigationBottomBar({String? id}) {
   return const IosAiBottomBar();
  }
}
