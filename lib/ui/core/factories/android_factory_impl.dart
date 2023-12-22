import 'package:flutter/material.dart';
import 'package:story_teller/ui/core/factories/widgets/button/android/android_button.dart';
import 'package:story_teller/ui/core/factories/widgets/clickable_card/android/android_clickable_card.dart';
import 'package:story_teller/ui/core/factories/widgets/text_form_field/android/text_form_field.dart';
import 'package:story_teller/domain/factories/widgets_factory.dart';
import 'package:story_teller/ui/core/factories/widgets/app_bar/android/navigation_app_bar.dart';

import 'widgets/bottom_bar/android/navigation_bottom_bar.dart';

class AndroidFactory implements WidgetFactory {
  @override
  Widget createButton({
    VoidCallback? clickFunction,
    bool? isFixedSize,
    double? height,
    double? width,
    double? borderSide,
    double? iosHeight,
    double? iosWidth,
    double? androidHeight,
    double? androidWidth,
    required String text,
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
    return AndroidAiButton(
      clickFunction: clickFunction,
      backgroundColor: androidBackgroundColor ?? bgColor,
      isFixedSize: isFixedSize ?? false,
      text: text,
      textStyle: androidTextStyle ?? textStyle,
      height: androidHeight ?? height,
      width: androidWidth ?? width,
      padding: androidPadding ?? padding,
      borderSide: borderSide,
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
        clickFunction: clickFunction,
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
    VoidCallback? leftTapFunction,
    VoidCallback? rightTapFunction,
  }) {
    return AndroidNavigationAppBar(
      title: title ?? "",
      leftIcon: leftIcon ?? "",
      rightIcon: rightIcon ?? "",
      leftTapFunction: leftTapFunction ?? () => {},
      rightTapFunction: rightTapFunction ?? () => {},
    );
  }

  @override
  Widget navigationBottomBar({
    required List<BottomNavigationBarItem> materialItems,
    required List<BottomNavigationBarItem> cupertinoItems,
    required int index,
    required void Function(int) onTapFunction,
  }) {
    return AndroidAiBottomBar(
      materialItems: materialItems,
      cupertinoItems: cupertinoItems,
      index: index,
      onTapFunction: onTapFunction,
    );
  }

  @override
  Widget textFormField({
    Key? key,
    VoidCallback? onChangedFunction,
    int? maxLines,
    TextInputType? keyboardType,
    String? hintText,
    double? contentPadding,
    double? borderRadius,
    double? borderSide,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool? obscureText,
    String? obscuringCharacter,
    String? Function(String?)? validator,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool? filled,
    Color? fillColor,
    Color? androidFillColor,
    Color? iosFillColor,
    void Function(String)? onFieldSubmitFunction,
    void Function(PointerDownEvent)? onTapOutSide,
  }) {
    return AndroidTextFormField(
      onChangedFunction: onChangedFunction,
      onFieldSubmitFunction: onFieldSubmitFunction,
      onTapOutSide: onTapOutSide,
      focusNode: focusNode,
      maxLines: maxLines,
      validator: validator,
      controller: controller,
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
