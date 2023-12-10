// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/widgets/app_bar/ios/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/bottom_bar/ios/navigation_bottom_bar.dart';
import 'package:story_teller/ui/core/widgets/button/ios/ios_button.dart';
import 'package:story_teller/ui/core/widgets/clickable_card/ios/ios_clickable_card.dart';
import 'package:story_teller/domain/widgets/ai_navigation_bar.dart';
import 'package:story_teller/ui/core/widgets/text_form_field/ios/text_form_field.dart';

class IOSFactory implements WidgetFactory {
  @override
  Widget createButton({
    double? height,
    double? width,
    double? iosHeight,
    double? iosWidth,
    double? androidHeight,
    double? androidWidth,
    TextStyle? textStyle,
    TextStyle? androidTextStyle,
    TextStyle? iosTextStyle,
    double? padding = 8.0,
    Color? bgColor,
    String? text,
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return IosAiButton(
      text: text,
      textStyle: iosTextStyle ?? textStyle,
      height: iosHeight ?? height,
      width: iosWidth ?? width,
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

  @override
  Widget textFormField(
      {Key? key,
      Function? onChangedFunction,
      TextInputType? keyboardType,
      String? hintText,
      double? contentPadding,
      double? borderRadius,
      double? borderSide,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool? obscureText,
      String? obscuringCharacter,
      bool? filled,
      Color? fillColor,
      Color? androidFillColor,
      Color? iosFillColor}) {
   
    return  IosTextFormField(
      onChangedFunction: onChangedFunction,
      keyboardType: keyboardType,
      hintText: hintText,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderSide: borderSide,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      filled: filled,
      fillColor: iosFillColor ?? fillColor,
    );
  }
}
