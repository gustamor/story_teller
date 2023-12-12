import 'package:flutter/material.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/widgets/app_bar/android/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/button/android/android_button.dart';
import 'package:story_teller/ui/core/widgets/clickable_card/android/android_clickable_card.dart';

import '../widgets/bottom_bar/android/navigation_bottom_bar.dart';
import '../widgets/text_form_field/android/text_form_field.dart';

class AndroidFactory implements WidgetFactory {
  @override
  Widget createButton({
    VoidCallback? clickFunction,
    double? height,
    double? width,
    double? iosHeight,
    double? iosWidth,
    double? androidHeight,
    double? androidWidth,
    String? text,
    TextStyle? textStyle,
    TextStyle? androidTextStyle,
    TextStyle? iosTextStyle,
    double? padding = 0.0,
    Color? bgColor,
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    final log = LogImpl();

    log.d("2 android factory impl");
    return AndroidAiButton(
      clickFunction: clickFunction,
      text: text,
      textStyle: androidTextStyle ?? textStyle,
      height: androidHeight ?? height,
      width: androidWidth ?? width,
      padding: androidPadding ?? padding,
      backgroundColor: androidBackgroundColor ?? bgColor,
    );
  }

  @override
  Widget createClickableCard({
    VoidCallback? clickFunction,
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
    return AndroidTextFormField(
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
      fillColor: androidFillColor ?? fillColor,
    );
  }
}
