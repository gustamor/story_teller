// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_teller/data/services/shared_preferences_service.dart';
import 'package:story_teller/domain/providers/theme_mode_provider.dart';
import 'package:story_teller/data/di/shared_preferences.dart';

/// A provider for managing the theme mode of the application.
///
/// This provider uses [SharedPreferencesService] to persist the theme mode
/// across app launches. It allows switching between light and dark themes
/// or using the system default.
final themeModeProvider =
    StateNotifierProvider<ThemeModeProvider, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeProvider(prefs);
});

/// The state notifier for the theme mode of the application.
///
/// This class extends [StateNotifier] with [ThemeMode] and implements
/// [ThemesProvider]. It manages the theme mode state and interacts with
/// [SharedPreferencesService] for persistence.
class ThemeModeProvider extends StateNotifier<ThemeMode>
    implements ThemesProvider {
  final SharedPreferencesService prefs;

  /// Initializes [ThemeModeProvider] with [SharedPreferencesService].
  ///
  /// The constructor sets the initial theme mode to [ThemeMode.system] and
  /// calls [_loadThemeMode] to load the persisted theme mode.
  ThemeModeProvider(this.prefs) : super(ThemeMode.system) {
    _loadThemeMode();
  }

  /// Loads the theme mode from shared preferences and updates the state.
  ///
  /// The function retrieves the theme mode string from shared preferences,
  /// converts it to a [ThemeMode] using [stringToThemeMode], and updates
  /// the state with the retrieved mode.
  Future<void> _loadThemeMode() async {
    final modeStored = await prefs.getString('themeMode');
    final mode = stringToThemeMode(modeStored);
    state = mode;
  }

  /// Switches the current theme mode based on the provided boolean value.
  ///
  /// When [isOn] is true, sets the theme to [ThemeMode.dark], otherwise
  /// sets it to [ThemeMode.light]. It then updates the state and persists
  /// the new mode.
  @override
  void switchTheme(bool isOn) {
    final newMode = isOn ? ThemeMode.dark : ThemeMode.light;
    _setThemeMode(newMode);
  }

  /// Changes the theme mode to the specified [mode].
  ///
  /// Updates the state with the given [mode] and persists this change.
  @override
  void changeTheme(ThemeMode mode) {
    _setThemeMode(mode);
  }

  /// Sets the theme mode to the provided [mode] and persists it.
  ///
  /// Updates the state with the given [mode] and saves it to shared preferences.
  void _setThemeMode(ThemeMode mode) {
    state = mode;
    prefs.setString(
      'themeMode',
      state.toString(),
    );
  }
}

/// Converts a string representation of theme mode to [ThemeMode].
///
/// Accepts a string [mode] and returns the corresponding [ThemeMode].
/// Defaults to [ThemeMode.system] for unrecognized strings.
ThemeMode stringToThemeMode(String mode) {
  switch (mode) {
    case 'ThemeMode.dark':
      return ThemeMode.dark;
    case 'ThemeMode.light':
      return ThemeMode.light;
    default:
      return ThemeMode.system; // Or a default value of your preference
  }
}