import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_teller/domain/providers/themes_provider.dart';

final sharedPrefs = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

final themesProvider =
    StateNotifierProvider<ThemesProviderImpl, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPrefs);
  var storedMode = ThemeMode.dark.toString();
  prefs.whenData((value) {
    storedMode = value.getString('themeMode') ?? ThemeMode.dark.toString();
  });

  var mode = ThemeMode.values.firstWhere((e) => e.toString() == storedMode);
  return ThemesProviderImpl(mode, prefs);
});

class ThemesProviderImpl extends StateNotifier<ThemeMode>
    implements ThemesProvider {
  final AsyncValue<SharedPreferences> prefs;

  ThemesProviderImpl(super.state, this.prefs);

  @override
  void switchTheme(bool isOn) {
      state = isOn ? ThemeMode.dark : ThemeMode.light;
      prefs.whenData(
      (pref) => pref.setString(
        'themeMode',
        state.toString(),
      ),
    );  
  }

  @override
  void changeTheme(ThemeMode mode) {
    state = mode;
  }
}
