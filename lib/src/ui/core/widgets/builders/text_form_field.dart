import 'package:flutter/widgets.dart';
import 'package:story_teller/src/ui/core/factories/specific_platform_factory.dart';

class NiceTextFormField extends StatelessWidget {
  final VoidCallback? onChangedFunction;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? hintText;
  final double? contentPadding;
  final double? borderRadius;
  final double? borderSide;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? obscuringCharacter;
  final bool? filled;
  final Color? fillColor;
  final Color? androidFillColor;
  final Color? iosFillColor;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitFunction;
  final void Function(PointerDownEvent)? onTapOutSide;

  NiceTextFormField({
    super.key,
    this.onChangedFunction,
    this.keyboardType,
    this.hintText,
    this.contentPadding,
    this.borderRadius,
    this.borderSide,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.obscuringCharacter,
    this.filled,
    this.fillColor,
    this.androidFillColor,
    this.iosFillColor,
    this.maxLines,
    this.validator,
    this.controller,
    this.focusNode,
    this.onFieldSubmitFunction,
    this.onTapOutSide,
    this.readOnly,
  });

  final ui = selectSpecificPlatformWidgetFactory();

  @override
  Widget build(BuildContext context) {
    return ui.textFormField(
      onChangedFunction: onChangedFunction,
      onFieldSubmitFunction: onFieldSubmitFunction,
      onTapOutSide: onTapOutSide,
      focusNode: focusNode,
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      hintText: hintText,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderSide: borderSide,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      readOnly: readOnly,
      obscuringCharacter: obscuringCharacter,
      filled: filled,
      fillColor: fillColor,
    );
  }
}
