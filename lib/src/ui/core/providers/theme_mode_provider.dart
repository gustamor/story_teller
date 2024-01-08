// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_teller/src/data/services/shared_preferences_service.dart';
import 'package:story_teller/src/domain/providers/theme_mode_provider.dart';
import 'package:story_teller/src/data/di/shared_preferences.dart';

final themeModeProvider =
    StateNotifierProvider<ThemeModeProvider, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  var storedMode = ThemeMode.dark.toString();
  prefs.getString('themeMode');
  /*  prefs.whenData((value) {
    storedMode = value.getString('themeMode') ?? ThemeMode.dark.toString();
  }); */

  var mode = ThemeMode.values.firstWhere((e) => e.toString() == storedMode);
  return ThemeModeProvider(mode, prefs);
});

class ThemeModeProvider extends StateNotifier<ThemeMode>
    implements ThemesProvider {
  final SharedPreferencesService prefs;

  ThemeModeProvider(super.state, this.prefs);

  @override
  void switchTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
    prefs.setString(
      'themeMode',
      state.toString(),
    );
 
  }

  @override
  void changeTheme(ThemeMode mode) {
    state = mode;
  }
}
