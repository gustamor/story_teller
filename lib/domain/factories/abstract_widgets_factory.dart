import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A factory for creating various UI widgets with platform-specific customizations.
///
/// This abstract class defines methods for creating buttons, clickable cards,
/// navigation bars, and text form fields. It allows for consistent widget creation
/// with customizable parameters to accommodate different platform-specific styles and behaviors.
abstract class AbstractWidgetFactory {

  /// Creates a button widget with customizable properties and platform-specific styles.
  ///
  /// Allows configuration of dimensions, text styles, colors, padding, and more.
  /// Supports platform-specific customization for iOS and Android.
  ///
  /// - Parameters:
  ///   - `clickFunction`: Function executed when the button is tapped.
  ///   - `isFixedSize`: If true, the button has a fixed size.
  ///   - `text`: Display text of the button.
  ///   - Text and color styles: `textStyle`, `androidTextStyle`, `iosTextStyle`, `bgColor`, `foregroundColor`, `iosBackgroundColor`, `androidBackgroundColor`.
  ///   - Dimensions and padding: height, width, borderSide, padding, etc., for both platforms.
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
    double? padding,
    Color? bgColor,
    Color? foregroundColor,
    Color? iosBackgroundColor,
    Color? androidBackgroundColor,
    double? iosPadding,
    double? androidPadding,
  });

  /// Creates a clickable card widget with customizable properties.
  ///
  /// The card can display a caption, description, and an optional child widget,
  /// customizable with styles, colors, and dimensions.
  ///
  /// - Parameters:
  ///   - `clickFunction`: Function executed when the card is tapped.
  ///   - `caption`, `description`: Text contents of the card.
  ///   - `textStyle`: Style for the caption and description.
  ///   - Background colors: `bgColor`, `androidBackgroundColor`, `iosBackgroundColor`.
  ///   - Other style parameters: shadow, elevation, shape, margins, etc.
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
  });

  /// Creates a navigation bar for the top of the app screen.
  ///
  /// The bar displays a title, left and right icons, with tap actions for the icons.
  ///
  /// - Parameters:
  ///   - `title`: Title text of the navigation bar.
  ///   - `leftIcon`, `rightIcon`: Icons on the left and right side.
  ///   - `leftTapFunction`, `rightTapFunction`: Functions executed on icon taps.
  Widget navigationAppBar({
    String? title,
    String? leftIcon,
    String? rightIcon,
    VoidCallback? leftTapFunction,
    VoidCallback? rightTapFunction,
  });

  /// Creates a bottom navigation bar with customizable items and tap handling.
  ///
  /// - Parameters:
  ///   - `materialItems`, `cupertinoItems`: Items for Material and Cupertino designs.
  ///   - `index`: Index of the currently active item.
  ///   - `onTapFunction`: Function executed when an item is tapped.
  Widget navigationBottomBar({
    required List<BottomNavigationBarItem> materialItems,
    required List<BottomNavigationBarItem> cupertinoItems,
    required int index,
    required void Function(int) onTapFunction,
  });

  /// Creates a text form field with various customization options.
  ///
  /// Offers extensive customization for text input fields, including input handling,
  /// submission, validation, and visual feedback.
  ///
  /// - Parameters:
  ///   - `key`: Identifier for this widget.
  ///   - Input handling: `onChangedFunction`, `onFieldSubmitFunction`.
  ///   - `validator`: Function for input validation.
  ///   - State management: `controller`, `focusNode`.
  ///   - Appearance and behavior: `maxLines`, `keyboardType`, `hintText`, `contentPadding`, etc.
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
    Color? androidFillColor,
    Color? iosFillColor,
    bool? readOnly,
    String? Function(String?)? validator,
    TextEditingController? controller,
    FocusNode? focusNode,
    void Function(String)? onFieldSubmitFunction,
    void Function(PointerDownEvent)? onTapOutSide,
  });
}
