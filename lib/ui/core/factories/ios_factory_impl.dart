// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:story_teller/ui/core/factories/widgets/button/ios/ios_button.dart';
import 'package:story_teller/ui/core/factories/widgets/clickable_card/ios/ios_clickable_card.dart';
import 'package:story_teller/ui/core/factories/widgets/text_form_field/ios/ios_text_form_field.dart';
import 'package:story_teller/domain/abstract/factories/abstract_widgets_factory.dart';
import 'package:story_teller/ui/core/factories/widgets/app_bar/ios/ios_navigation_app_bar.dart';
import 'package:story_teller/ui/core/factories/widgets/bottom_bar/ios/ios_navigation_bottom_bar.dart';

import 'package:story_teller/domain/abstract/widgets/abstract_ai_navigation_bar.dart';

/// A factory for creating iOS-specific UI widgets.
///
/// Implements the [AbstractWidgetFactory] to provide widget creation methods
/// that are tailored for the iOS platform, ensuring a consistent
/// user experience on iOS devices.
class IOSFactory implements AbstractWidgetFactory {
  /// Creates an iOS-style button with customizable properties.
  ///
  /// This method provides extensive customization for buttons, including
  /// handling click actions, appearance, and platform-specific styling.
  ///
  /// - Parameters:
  ///   - `clickFunction`: Function to execute when the button is tapped.
  ///   - `isFixedSize`: Determines if the button has a fixed size.
  ///   - `height`: Height of the button. Falls back to `iosHeight` if provided.
  ///   - `width`: Width of the button. Falls back to `iosWidth` if provided.
  ///   - `borderSide`: Width of the border surrounding the button.
  ///   - `iosHeight`: Height of the button specific to iOS styling. Overrides `height` if provided.
  ///   - `iosWidth`: Width of the button specific to iOS styling. Overrides `width` if provided.
  ///   - `androidHeight`: Height of the button specific to Android styling. Currently unused in iOS context.
  ///   - `androidWidth`: Width of the button specific to Android styling. Currently unused in iOS context.
  ///   - `text`: Text to display on the button.
  ///   - `textStyle`: Text style for the button text. Falls back to `iosTextStyle` if provided.
  ///   - `iosTextStyle`: Text style specific to iOS styling. Overrides `textStyle` if provided.
  ///   - `androidTextStyle`: Text style specific to Android styling. Currently unused in iOS context.
  ///   - `padding`: Padding inside the button. Falls back to `iosPadding` if provided.
  ///   - `bgColor`: Background color of the button. Falls back to `iosBackgroundColor` if provided.
  ///   - `foregroundColor`: Foreground color (usually the color of the text or icon) of the button.
  ///   - `androidBackgroundColor`: Background color specific to Android styling. Currently unused in iOS context.
  ///   - `iosBackgroundColor`: Background color specific to iOS styling. Overrides `bgColor` if provided.
  ///   - `androidPadding`: Padding inside the button specific to Android styling. Currently unused in iOS context.
  ///   - `iosPadding`: Padding inside the button specific to iOS styling. Overrides `padding` if provided.
  @override
  Widget createButton({
    required VoidCallback clickFunction,
    bool? isFixedSize,
    double? height,
    double? width,
    double? borderSide,
    double? iosHeight,
    double? iosWidth,
    double? androidHeight,
    double? androidWidth,
    TextStyle? textStyle,
    TextStyle? androidTextStyle,
    TextStyle? iosTextStyle,
    double? padding = 8.0,
    Color? bgColor,
    Color? foregroundColor,
    required String text,
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return IosAiButton(
      clickFunction: clickFunction,
      backgroundColor: iosBackgroundColor ?? bgColor,
      foregroundColor: foregroundColor,
      isFixedSize: isFixedSize,
      text: text,
      textStyle: iosTextStyle ?? textStyle,
      height: iosHeight ?? height,
      width: iosWidth ?? width,
      borderSide: borderSide,
      padding: iosPadding ?? padding,
    );
  }

  /// Creates an iOS-style clickable card with customizable properties.
  ///
  /// - Parameters:
  ///   - `clickFunction`: Function to execute when the card is tapped.
  ///   - `height`: Height of the card.
  ///   - `width`: Width of the card.
  ///   - `caption`: Caption text of the card.
  ///   - `description`: Description text of the card.
  ///   - `textStyle`: Text style for the caption and description.
  ///   - `bgColor`: Background color of the card.
  ///   - `iosBackgroundColor`: Background color specific to iOS styling. Overrides `bgColor` if provided.
  ///   - `surfaceTintColor`: Tint color applied to the surface of the card.
  ///   - `shadowColor`: Color of the shadow cast by the card.
  ///   - `elevation`: Elevation of the card (depth effect).
  ///   - `shape`: Shape of the card's border.
  ///   - `margin`: Margin around the card.
  ///   - `clipBehavior`: Clipping behavior for the card.
  ///   - `decorImage`: Path or URL of the decorative image on the card.
  ///   - `fit`: How the card's content should be inscribed into the available space.
  ///   - `borderRadius`: Border radius of the card.
  ///   - `child`: Optional child widget to display inside the card.
  @override
  Widget createClickableCard({
    required VoidCallback clickFunction,
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
    BoxFit? fit,
    double? borderRadius,
    Widget? child,
  }) {
    return IosClickableCard(
      height: height,
      width: width,
      caption: caption,
      description: description,
      decorImage: decorImage,
      clickFunction: clickFunction,
      fit: fit,
      borderRadius: borderRadius,
    );
  }

  /// Creates an iOS-style navigation app bar with customizable properties.
  ///
  /// - Parameters:
  ///   - `title`: Title text to display in the app bar.
  ///   - `leftIcon`: Icon to display on the left side of the app bar.
  ///   - `rightIcon`: Icon to display on the right side of the app bar.
  ///   - `leftTapFunction`: Function to execute when the left icon is tapped.
  ///   - `rightTapFunction`: Function to execute when the right icon is tapped.
  @override
  Widget navigationAppBar({
    String? title,
    String? leftIcon,
    String? rightIcon,
    VoidCallback? leftTapFunction,
    VoidCallback? rightTapFunction,
  }) {
    return IosNavigationAppBar(
      title: title ?? "",
      leftIcon: leftIcon ?? "",
      rightIcon: rightIcon ?? "",
      leftTapFunction: leftTapFunction ?? () => {},
      rightTapFunction: rightTapFunction ?? () => {},
    );
  }

  /// Creates an iOS-style bottom navigation bar with customizable properties.
  ///
  /// - Parameters:
  ///   - `materialItems`: List of items to display in the bottom bar for Material design.
  ///   - `cupertinoItems`: List of items to display in the bottom bar for Cupertino design.
  ///   - `index`: Index of the currently active item.
  ///   - `onTapFunction`: Function to execute when an item is tapped.
  @override
  Widget navigationBottomBar({
    required List<BottomNavigationBarItem> materialItems,
    required List<BottomNavigationBarItem> cupertinoItems,
    required int index,
    required void Function(int) onTapFunction,
  }) {
    return IosAiBottomBar(
      materialItems: materialItems,
      cupertinoItems: cupertinoItems,
      index: index,
      onTapFunction: onTapFunction,
    );
  }

  /// Creates an iOS-style text form field with customizable properties.
  ///
  /// This method provides extensive customization for text input fields, including
  /// handling changes, submission, validation, and providing visual feedback.
  ///
  /// - Parameters:
  ///   - `onChangedFunction`: Function to execute when the input text changes.
  ///   - `maxLines`: Maximum number of lines for the input field.
  ///   - `keyboardType`: Type of keyboard to display for the text input field.
  ///   - `hintText`: Hint text to display when the input field is empty.
  ///   - `contentPadding`: Padding around the content of the input field.
  ///   - `borderRadius`: Border radius of the input field.
  ///   - `borderSide`: Width of the border around the input field.
  ///   - `prefixIcon`: Widget to display before the input field (prefix).
  ///   - `suffixIcon`: Widget to display after the input field (suffix).
  ///   - `obscureText`: Determines whether the input field obscures the text entered (for passwords).
  ///   - `obscuringCharacter`: Character used to obscure text if `obscureText` is true.
  ///   - `validator`: Function for input validation.
  ///   - `controller`: Controller for managing the text in the input field.
  ///   - `focusNode`: Focus node for managing the input field's focus state.
  ///   - `filled`: Determines whether the input field is filled with a color.
  ///   - `fillColor`: Color used to fill the input field. Falls back to `iosFillColor` if provided.
  ///   - `readOnly`: Determines whether the input field is read-only.
  ///   - `onFieldSubmitFunction`: Function to execute when the user submits the input field (e.g., pressing enter).
  ///   - `onTapOutSide`: Function to execute when the user taps outside the input field.
  @override
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
    String? Function(String?)? validator,
    TextEditingController? controller,
    FocusNode? focusNode,
    Color? androidFillColor,
    Color? iosFillColor,
    bool? readOnly,
    void Function(String)? onFieldSubmitFunction,
    void Function(PointerDownEvent)? onTapOutSide,
  }) {
    return IosTextFormField(
      onChangedFunction: onChangedFunction,
      onFieldSubmitFunction: onFieldSubmitFunction,
      onTapOutSide: onTapOutSide,
      focusNode: focusNode,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      hintText: hintText,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderSide: borderSide,
      readOnly: readOnly,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      filled: filled,
      fillColor: iosFillColor ?? fillColor,
    );
  }
}
