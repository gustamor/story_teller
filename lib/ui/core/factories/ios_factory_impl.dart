// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:story_teller/ui/core/factories/widgets/button/ios/ios_button.dart';
import 'package:story_teller/ui/core/factories/widgets/clickable_card/ios/ios_clickable_card.dart';
import 'package:story_teller/ui/core/factories/widgets/text_form_field/ios/text_form_field.dart';
import 'package:story_teller/domain/factories/abstract_widgets_factory.dart';
import 'package:story_teller/ui/core/factories/widgets/app_bar/ios/navigation_app_bar.dart';
import 'package:story_teller/ui/core/factories/widgets/bottom_bar/ios/navigation_bottom_bar.dart';

import 'package:story_teller/domain/widgets/ai_navigation_bar.dart';

class IOSFactory implements WidgetFactory {
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
    TextStyle? textStyle,
    TextStyle? androidTextStyle,
    TextStyle? iosTextStyle,
    double? padding = 8.0,
    Color? bgColor,
    Color? foregroundColor,
    required String text,
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return IosAiButton(
      clickFunction: clickFunction,
      backgroundColor: iosBackgroundColor ?? bgColor,
      foregroundColor: foregroundColor,
      isFixedSize: isFixedSize,
      text: text,
      textStyle: iosTextStyle ?? textStyle,
      height: iosHeight ?? height,
      width: iosWidth ?? width,
      borderSide: borderSide,
      padding: iosPadding ?? padding,
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
    VoidCallback? leftTapFunction,
    VoidCallback? rightTapFunction,
  }) {
    return IosNavigationAppBar(
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
    return IosAiBottomBar(
      materialItems: materialItems,
      index: index,
      onTapFunction: onTapFunction,
      cupertinoItems: cupertinoItems,
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
    bool? filled,
    Color? fillColor,
    String? Function(String?)? validator,
    TextEditingController? controller,
    FocusNode? focusNode,
    Color? androidFillColor,
    Color? iosFillColor,
    void Function(String)? onFieldSubmitFunction,
    void Function(PointerDownEvent)? onTapOutSide,
  }) {
    return IosTextFormField(
      onChangedFunction: onChangedFunction,
      onFieldSubmitFunction: onFieldSubmitFunction,
      onTapOutSide: onTapOutSide,
      focusNode: focusNode,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
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
