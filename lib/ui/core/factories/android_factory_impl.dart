import 'package:flutter/material.dart';
import 'package:story_teller/ui/core/factories/widgets/button/android/android_button.dart';
import 'package:story_teller/ui/core/factories/widgets/clickable_card/android/android_clickable_card.dart';
import 'package:story_teller/ui/core/factories/widgets/text_form_field/android/android_text_form_field.dart';
import 'package:story_teller/domain/factories/abstract_widgets_factory.dart';
import 'package:story_teller/ui/core/factories/widgets/app_bar/android/android_navigation_app_bar.dart';

import 'widgets/bottom_bar/android/android_navigation_bottom_bar.dart';

/// A factory for creating Android-specific UI widgets.
///
/// This class implements [AbstractWidgetFactory] to provide creation methods
/// for widgets that adhere to Android design principles, ensuring a consistent
/// user experience on Android devices.
class AndroidFactory implements AbstractWidgetFactory {
  /// Creates an Android-style button with customizable properties.
  ///
  /// This method provides extensive customization for buttons, including
  /// handling click actions, appearance, and platform-specific styling.
  ///
  /// - Parameters:
  ///   - `clickFunction`: Function to execute when the button is tapped.
  ///   - `isFixedSize`: Determines if the button has a fixed size. Defaults to `false` if not provided.
  ///   - `height`: Height of the button. Falls back to `androidHeight` if provided.
  ///   - `width`: Width of the button. Falls back to `androidWidth` if provided.
  ///   - `borderSide`: Width of the border surrounding the button.
  ///   - `iosHeight`: Height of the button specific to iOS styling. Currently unused in Android context.
  ///   - `iosWidth`: Width of the button specific to iOS styling. Currently unused in Android context.
  ///   - `androidHeight`: Height of the button specific to Android styling. Overrides `height` if provided.
  ///   - `androidWidth`: Width of the button specific to Android styling. Overrides `width` if provided.
  ///   - `text`: Text to display on the button.
  ///   - `textStyle`: Text style for the button text. Falls back to `androidTextStyle` if provided.
  ///   - `androidTextStyle`: Text style specific to Android styling. Overrides `textStyle` if provided.
  ///   - `iosTextStyle`: Text style specific to iOS styling. Currently unused in Android context.
  ///   - `padding`: Padding inside the button. Falls back to `androidPadding` if provided.
  ///   - `bgColor`: Background color of the button. Falls back to `androidBackgroundColor` if provided.
  ///   - `foregroundColor`: Foreground color (usually the color of the text or icon) of the button.
  ///   - `androidBackgroundColor`: Background color specific to Android styling. Overrides `bgColor` if provided.
  ///   - `androidPadding`: Padding inside the button specific to Android styling. Overrides `padding` if provided.
  ///   - `iosPadding`: Padding inside the button specific to iOS styling. Currently unused in Android context.
  ///   - `iosBackgroundColor`: Background color specific to iOS styling. Currently unused in Android context.
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
    required String text,
    TextStyle? textStyle,
    TextStyle? androidTextStyle,
    TextStyle? iosTextStyle,
    double? padding = 0.0,
    Color? bgColor,
    Color? foregroundColor,
    Color? androidBackgroundColor,
    double? androidPadding,
    double? iosPadding,
    Color? iosBackgroundColor,
  }) {
    return AndroidAiButton(
      clickFunction: clickFunction,
      backgroundColor: androidBackgroundColor ?? bgColor,
      foregroundColor: foregroundColor,
      isFixedSize: isFixedSize ?? false,
      text: text,
      textStyle: androidTextStyle ?? textStyle,
      height: androidHeight ?? height,
      width: androidWidth ?? width,
      padding: androidPadding ?? padding,
      borderSide: borderSide,
    );
  }

  /// Creates an Android-style clickable card with customizable properties.
  ///
  /// - Parameters:
  ///   - `clickFunction`: Function to execute when the card is tapped.
  ///   - `height`: Height of the card.
  ///   - `width`: Width of the card.
  ///   - `caption`: Caption text of the card.
  ///   - `description`: Description text of the card.
  ///   - `textStyle`: Text style for the caption and description.
  ///   - `bgColor`: Background color of the card.
  ///   - `androidBackgroundColor`: Background color specific to Android styling. Overrides `bgColor` if provided.
  ///   - `iosBackgroundColor`: Background color specific to iOS styling. Currently unused in Android context.
  ///   - `surfaceTintColor`: Tint color applied to the surface of the card.
  ///   - `shadowColor`: Color of the shadow cast by the card.
  ///   - `androidShadowColor`: Shadow color specific to Android styling. Overrides `shadowColor` if provided.
  ///   - `elevation`: Elevation of the card (depth effect).
  ///   - `androidElevation`: Elevation specific to Android styling. Overrides `elevation` if provided.
  ///   - `shape`: Shape of the card's border.
  ///   - `margin`: Margin around the card.
  ///   - `clipBehavior`: Clipping behavior for the card.
  ///   - `decorImage`: Path or URL of the decorative image on the card.
  ///   - `borderRadius`: Border radius of the card.
  ///   - `fit`: How the card's content should be inscribed into the available space.
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
    double? borderRadius,
    BoxFit? fit,
    Widget? child,
  }) {
    return AndroidAiClickableCard(
        clickFunction: clickFunction,
        caption: caption,
        description: description,
        decorImage: decorImage,
        height: height,
        width: width,
        borderRadius: borderRadius,
        textStyle: textStyle,
        bgColor: bgColor,
        androidBackgroundColor: androidBackgroundColor,
        surfaceTintColor: surfaceTintColor,
        shadowColor: shadowColor,
        androidShadowColor: androidShadowColor,
        elevation: elevation,
        androidElevation: androidElevation,
        shape: shape,
        margin: margin,
        clipBehavior: clipBehavior,
        fit: fit,
        child: child);
  }

  /// Creates an Android-style navigation app bar with customizable properties.
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
    return AndroidNavigationAppBar(
      title: title ?? "",
      leftIcon: leftIcon ?? "",
      rightIcon: rightIcon ?? "",
      leftTapFunction: leftTapFunction ?? () => {},
      rightTapFunction: rightTapFunction ?? () => {},
    );
  }

  /// Creates an Android-style bottom navigation bar with customizable properties.
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
    return AndroidAiBottomBar(
      materialItems: materialItems,
      cupertinoItems: cupertinoItems,
      index: index,
      onTapFunction: onTapFunction,
    );
  }

  /// Creates an Android-style text form field with customizable properties.
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
  ///   - `fillColor`: Color used to fill the input field. Falls back to `androidFillColor` if provided.
  ///   - `androidFillColor`: Fill color specific to Android styling. Overrides `fillColor` if provided.
  ///   - `iosFillColor`: Fill color specific to iOS styling. Currently unused in Android context.
  ///   - `readOnly`: Determines whether the input field is read-only.
  ///   - `onFieldSubmitFunction`: Function to execute when the user submits the input field (e.g., pressing enter).
  ///   - `onTapOutSide`: Function to execute when the user taps outside the input field.
  /// 
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
    String? Function(String?)? validator,
    TextEditingController? controller,
    FocusNode? focusNode,
    bool? filled,
    Color? fillColor,
    Color? androidFillColor,
    Color? iosFillColor,
    bool? readOnly,
    void Function(String)? onFieldSubmitFunction,
    void Function(PointerDownEvent)? onTapOutSide,
  }) {
    return AndroidTextFormField(
      onChangedFunction: onChangedFunction,
      onFieldSubmitFunction: onFieldSubmitFunction,
      onTapOutSide: onTapOutSide,
      focusNode: focusNode,
      maxLines: maxLines,
      validator: validator,
      controller: controller,
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
      fillColor: androidFillColor ?? fillColor,
    );
  }
}
