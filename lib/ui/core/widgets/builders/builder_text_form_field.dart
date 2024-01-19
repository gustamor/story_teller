import 'package:flutter/widgets.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';

/// A customizable text form field widget that adapts its appearance based on the platform (Android or iOS).
///
/// This widget wraps a text field and provides custom styling and behavior to align with
/// platform-specific design guidelines. It uses a platform-specific widget factory to create a text field
/// that conforms to the design guidelines of the target platform.
class NiceTextFormField extends StatelessWidget {
  /// Callback function triggered when the field's content is changed.
  final VoidCallback? onChangedFunction;
  
  /// Maximum number of lines the field can occupy.
  final int? maxLines;
  
  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;
  
  /// Placeholder text that appears when the field is empty.
  final String? hintText;
  
  /// Padding around the content of the field.
  final double? contentPadding;
  
  /// The border radius of the text field.
  final double? borderRadius;
  
  /// The width of the border around the text field.
  final double? borderSide;
  
  /// An optional widget to display at the start of the field.
  final Widget? prefixIcon;
  
  /// An optional widget to display at the end of the field.
  final Widget? suffixIcon;
  
  /// Whether the text should be obscured (useful for passwords).
  final bool? obscureText;
  
  /// The character used to obscure text if [obscureText] is true.
  final String? obscuringCharacter;
  
  /// Whether the text field is filled with a color (specified by [fillColor]).
  final bool? filled;
  
  /// The background color of the text field.
  final Color? fillColor;
  
  /// The background color to use for the text field when the platform is Android.
  final Color? androidFillColor;
  
  /// The background color to use for the text field when the platform is iOS.
  final Color? iosFillColor;
  
  /// Whether the text can be changed.
  final bool? readOnly;
  
  /// Function that returns a validation error message based on the current field value.
  final String? Function(String?)? validator;
  
  /// Controller for the text being edited.
  final TextEditingController? controller;
  
  /// Focus node for managing the focus of the text field.
  final FocusNode? focusNode;
  
  /// Callback function triggered when the user indicates they are done editing the text (e.g., by pressing the 'submit' button on the keyboard).
  final void Function(String)? onFieldSubmitFunction;
  
  /// Callback function triggered when the user taps outside the text field.
  final void Function(PointerDownEvent)? onTapOutSide;

  /// Constructs a [NiceTextFormField] with the given properties.
  ///
  /// Initializes the text field with customizable attributes for appearance and behavior.
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

  /// A utility for selecting the appropriate widget factory based on the platform.
  final ui = selectSpecificPlatformWidgetFactory();

  /// Builds the visual structure of the text form field widget.
  ///
  /// Constructs the text form field using a platform-specific widget factory, ensuring the field adheres to
  /// the design language of the target platform (Android or iOS).
  @override
  Widget build(BuildContext context) {
    return ui.textFormField(
      onChangedFunction: onChangedFunction, // Triggers when text is changed.
      onFieldSubmitFunction: onFieldSubmitFunction, // Triggers when the user submits the field.
      onTapOutSide: onTapOutSide, // Triggers when the user taps outside the field.
      focusNode: focusNode, // Manages focus for this field.
      validator: validator, // Validates the field value.
      controller: controller, // Controls the text being edited.
      maxLines: maxLines ?? 1, // Sets the max number of lines for the text field.
      keyboardType: keyboardType, // Sets the type of keyboard for editing.
      hintText: hintText, // Sets the placeholder text.
      contentPadding: contentPadding, // Sets the padding around the content.
      borderRadius: borderRadius, // Sets the border radius.
      borderSide: borderSide, // Sets the border width.
      prefixIcon: prefixIcon, // Sets the prefix icon.
      suffixIcon: suffixIcon, // Sets the suffix icon.
      obscureText: obscureText ?? false, // Obscures the text if true.
      readOnly: readOnly ?? false, // Sets the read-only state of the text field.
      obscuringCharacter: obscuringCharacter, // Sets the obscuring character.
      filled: filled ?? false, // Determines if the field is filled with color.
      fillColor: fillColor, // Sets the fill color.
    );
  }
}
