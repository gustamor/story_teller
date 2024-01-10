// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/src/domain/abstract/widgets/ai_text_form_field.dart';

class AndroidTextFormField extends StatelessWidget implements AITextFormField {
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
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? fillColor;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitFunction;
  final void Function(PointerDownEvent)? onTapOutSide;

  const AndroidTextFormField({
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
    this.maxLines,
    this.validator,
    required this.controller,
    this.focusNode,
    this.onFieldSubmitFunction,
    this.onTapOutSide,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return TextFormField(
      onChanged: (query) => onChangedFunction,
      onFieldSubmitted: onFieldSubmitFunction ?? (value) {},
      onTapOutside: onTapOutSide,
      validator: validator,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.disabled,
      controller: controller,
      scrollPhysics: const ScrollPhysics(),
      enableSuggestions: true,
      showCursor: true,
      keyboardType: keyboardType,
      keyboardAppearance: Brightness.dark,
      autofocus: false,
      autocorrect: true,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter ?? "*",
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(
          12.r,
        ),
        constraints: BoxConstraints(
          maxHeight: 120,
          maxWidth: width,
        ),
        filled: filled ?? true,
        fillColor: fillColor,
        hintText: hintText,
        //  hintStyle:,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            (borderRadius ?? 30).r,
          ),
          borderSide: BorderSide(
            width: (borderSide ?? 3).w,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
