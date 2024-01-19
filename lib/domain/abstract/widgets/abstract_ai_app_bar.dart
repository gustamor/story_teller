import 'package:flutter/widgets.dart';

/// Represents an abstract app bar for AI-integrated applications.
///
/// This abstract class defines the structure and behavior of an app bar,
/// ensuring a consistent and intuitive user interface for applications that
/// integrate AI functionalities.
abstract class AbstractAiAppBar {

  /// Gets the title text to display in the app bar.
  String? get title;

  /// Gets the icon to display on the left side of the app bar.
  String? get leftIcon;

  /// Gets the icon to display on the right side of the app bar.
  String? get rightIcon;

  /// Gets the callback function to execute when the left icon is tapped.
  VoidCallback? get leftTapFunction;

  /// Gets the callback function to execute when the right icon is tapped.
  VoidCallback? get rightTapFunction;

  /// Determines the background opacity of the app bar.
  /// 
  /// A value of `true` makes the app bar more translucent, allowing the
  /// underlying content to be partially visible.
  bool? get backgroundOpacity;
}
