
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_text_form_field.dart';

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
  final Color? fillColor;

  const AndroidTextFormField(
      {super.key,
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
        this.maxLines});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController();

    return  TextFormField(
      onChanged: (query) => onChangedFunction,
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
        filled: filled!,
        fillColor: fillColor,
        hintText: hintText,
        //  hintStyle:,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            (borderRadius ?? 30).r,
          ),
          borderSide:  BorderSide(
            width: (borderSide ?? 3).w,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
