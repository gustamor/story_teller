import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_text_form_field.dart';

class IosTextFormField extends StatelessWidget implements AITextFormField {
  final Function? onChangedFunction;
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

  const IosTextFormField(
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
      this.fillColor});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController();

    return CupertinoTextField(
      onChanged: (query) => onChangedFunction,
      controller: controller,
      maxLines: 1,
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
      style: const TextStyle(color: CupertinoColors.placeholderText),
      placeholderStyle: const TextStyle(color:CupertinoColors.placeholderText),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          (borderRadius ?? 30).r,
        ),
          border: Border.all(color: Colors.red),

      ),

    );
  }
}
