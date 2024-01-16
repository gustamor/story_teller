import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/src/domain/abstract/widgets/ai_text_form_field.dart';

class IosTextFormField extends StatelessWidget implements AITextFormField {
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
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? readOnly;
  final void Function(String)? onFieldSubmitFunction;
  final void Function(PointerDownEvent)? onTapOutSide;

  const IosTextFormField({
    super.key,
    this.onChangedFunction,
    this.maxLines,
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
    this.validator,
    this.controller,
    this.focusNode,
    this.onFieldSubmitFunction,
    this.onTapOutSide, this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onChanged: (query) => onChangedFunction,
      onSubmitted: onFieldSubmitFunction ?? (value) {},
      onTapOutside: onTapOutSide,
      focusNode: focusNode,
      controller: controller,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      scrollPhysics: const ScrollPhysics(),
      enableSuggestions: true,
      showCursor: true,
      keyboardType: keyboardType,
      keyboardAppearance: Brightness.dark,
      autofocus: false,
      autocorrect: true,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter ?? "•",
      prefix: prefixIcon,
      suffix: suffixIcon,
      placeholder: hintText!,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          (borderRadius ?? 30).r,
        ),
        border: Border.all(color: Theme.of(context).disabledColor ),
      ),
    );
  }
}
