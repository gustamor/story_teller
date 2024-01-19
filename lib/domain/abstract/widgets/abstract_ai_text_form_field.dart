import 'package:flutter/widgets.dart';

/// Defines a text input field within an AI-driven context.
///
/// This abstract class specifies the blueprint for text input fields in AI-related interfaces,
/// ensuring standardized input handling, validation, and interaction patterns.
abstract class AbstractAiTextFormField {

  /// Gets the callback function to execute when the input text changes.
  VoidCallback? get onChangedFunction;

  /// Gets the type of keyboard to display for the text input field.
  TextInputType? get keyboardType;

  /// Gets the hint text to display when the input field is empty.
  String? get hintText;

  /// Gets the padding around the content of the input field.
  double? get contentPadding;

  /// Gets the border radius of the input field.
  double? get borderRadius;

  /// Gets the width of the border around the input field.
  double? get borderSide;

  /// Gets the widget to display before the input field (prefix).
  Widget? get prefixIcon;

  /// Gets the widget to display after the input field (suffix).
  Widget? get suffixIcon;

  /// Gets the maximum number of lines the input field allows.
  int? get maxLines;

  /// Determines whether the input field obscures the text entered (for passwords).
  bool? get obscureText;

  /// Gets the character used to obscure text if `obscureText` is true.
  String? get obscuringCharacter;

  /// Determines whether the input field is filled with a color.
  bool? get filled;

  /// Gets the validation function to apply to the input text.
  String? Function(String?)? get validator;

  /// Gets the controller for the text in the input field.
  TextEditingController? get controller;

  /// Gets the color used to fill the input field.
  Color? get fillColor;

  /// Gets the focus node for managing the input field's focus state.
  FocusNode? get focusNode;

  /// Determines whether the input field is read-only.
  bool? get readOnly;

  /// Gets the function to execute when the user submits the input field (e.g., pressing enter).
  void Function(String)? get onFieldSubmitFunction;

  /// Gets the function to execute when the user taps outside the input field.
  void Function(PointerDownEvent)? get onTapOutSide;
}
