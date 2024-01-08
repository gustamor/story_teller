import 'package:flutter/material.dart';

/// Abstract class for managing themes.
///
/// Defines the interface for theme management within an application. Implementations
/// of this class should provide concrete methods for switching and changing themes.
abstract class ThemesProvider {
  /// Switches the theme based on the provided [isOn] flag.
  ///
  /// Implementations should use this method to toggle between light and dark themes
  /// or other binary theme states. The [isOn] flag typically represents a user preference.
  void switchTheme(bool isOn);

  /// Changes the theme to a specific [ThemeMode].
  ///
  /// Implementations should use this method to set the theme of the application to
  /// the specified mode, which could be light, dark, or system default. The [mode]
  /// parameter determines the exact theme mode to switch to.
  void changeTheme(ThemeMode mode);
}
