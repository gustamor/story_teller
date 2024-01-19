import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_text_form_field.dart';

/// A customizable text form field widget tailored for iOS design guidelines.
///
/// This widget wraps a [CupertinoTextField] and provides custom styling and behavior to align with
/// iOS's design language. It implements [AbstractAiTextFormField] to ensure consistency and
/// reusability across different form implementations.
class IosTextFormField extends StatelessWidget implements AbstractAiTextFormField {
  
  /// Callback function triggered when the field's content is changed.
  @override
  final VoidCallback? onChangedFunction;
  
  /// Maximum number of lines the field can occupy.
  @override
  final int? maxLines;
  
  /// The type of keyboard to use for editing the text.
  @override
  final TextInputType? keyboardType;
  
  /// Placeholder text that appears when the field is empty.
  @override
  final String? hintText;
  
  /// Padding around the content of the field.
  @override
  final double? contentPadding;
  
  /// The border radius of the text field.
  @override
  final double? borderRadius;
  
  /// The width of the border around the text field.
  @override
  final double? borderSide;
  
  /// An optional widget to display at the start of the field.
  @override
  final Widget? prefixIcon;
  
  /// An optional widget to display at the end of the field.
  @override
  final Widget? suffixIcon;
  
  /// Whether the text should be obscured (useful for passwords).
  @override
  final bool? obscureText;
  
  /// The character used to obscure text if [obscureText] is true.
  @override
  final String? obscuringCharacter;
  
  /// Whether the text field is filled with a color (specified by [fillColor]).
  @override
  final bool? filled;
  
  /// The background color of the text field when [filled] is true.
  @override
  final Color? fillColor;
  
  /// Function that returns a validation error message based on the current field value.
  @override
  final String? Function(String?)? validator;
  
  /// Controller for the text being edited.
  @override
  final TextEditingController? controller;
  
  /// Focus node for managing the focus of the text field.
  @override
  final FocusNode? focusNode;
  
  /// Whether the text can be changed.
  @override
  final bool? readOnly;
  
  /// Callback function triggered when the user indicates they are done editing the text (e.g., by pressing the 'submit' button on the keyboard).
  @override
  final void Function(String)? onFieldSubmitFunction;
  
  /// Callback function triggered when the user taps outside the text field.
  @override
  final void Function(PointerDownEvent)? onTapOutSide;

  /// Constructs an [IosTextFormField] with the given properties.
  ///
  /// This constructor initializes the text field with customizable attributes for appearance and behavior.
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
    this.onTapOutSide,
    this.readOnly,
  });

  /// Builds the visual structure of the text form field widget.
  ///
  /// It constructs a [CupertinoTextField] with the specified styles, behaviors, and layout constraints.
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onChanged: (query) => onChangedFunction, // Triggers when text is changed.
      onSubmitted: onFieldSubmitFunction ?? (value) {}, // Triggers when the user submits the field.
      onTapOutside: onTapOutSide, // Triggers when the user taps outside the field.
      focusNode: focusNode, // Manages focus for this field.
      controller: controller, // Controls the text being edited.
      maxLines: maxLines ?? 1, // Sets the max number of lines for the text field.
      readOnly: readOnly ?? false, // Sets the read-only state of the text field.
      scrollPhysics: const ScrollPhysics(), // Physics for the scrollable content.
      enableSuggestions: true, // Enables suggestions for the text input.
      showCursor: true, // Shows the cursor in the text field.
      keyboardType: keyboardType, // Sets the type of keyboard for editing.
      keyboardAppearance: Brightness.dark, // Sets the appearance of the keyboard.
      autofocus: false, // Autofocuses the text field when it's displayed.
      autocorrect: true, // Enables autocorrect for the text input.
      obscureText: obscureText ?? false, // Obscures the text if true.
      obscuringCharacter: obscuringCharacter ?? "•", // Sets the obscuring character.
      prefix: prefixIcon, // Sets the prefix icon.
      suffix: suffixIcon, // Sets the suffix icon.
      placeholder: hintText!, // Sets the placeholder text.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((borderRadius ?? 30).r),
        border: Border.all(color: Theme.of(context).disabledColor),
      ),
    );
  }
}
