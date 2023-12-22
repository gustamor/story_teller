import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WidgetFactory {
  Widget createButton(
      {VoidCallback clickFunction,
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
      double? padding,
      Color? bgColor,
      Color? iosBackgroundColor,
      Color? androidBackgroundColor,
      double? iosPadding,
      double? androidPadding});

  Widget createClickableCard({
    VoidCallback clickFunction,
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
    VoidCallback? leftTapFunction,
    VoidCallback? rightTapFunction,
  });

  Widget navigationBottomBar({
    required List<BottomNavigationBarItem> materialItems,
    required List<BottomNavigationBarItem> cupertinoItems,
    required int index,
    required void Function(int) onTapFunction,
  });

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
    Color? androidFillColor,
    Color? iosFillColor,
    String? Function(String?)? validator,
    TextEditingController? controller,
    FocusNode? focusNode,
    void Function(String)? onFieldSubmitFunction,
    void Function(PointerDownEvent)? onTapOutSide,
  });
}
