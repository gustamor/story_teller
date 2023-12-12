import 'package:flutter/widgets.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceTextFormField extends StatelessWidget {
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
  final Color? androidFillColor;
  final Color? iosFillColor;

   NiceTextFormField(
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
      this.androidFillColor,
      this.iosFillColor});

  final ui = uiFactory();

  @override
  Widget build(BuildContext context) {
    return ui.textFormField(
       onChangedFunction : onChangedFunction,
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
       fillColor: fillColor,
    );
  }
}
