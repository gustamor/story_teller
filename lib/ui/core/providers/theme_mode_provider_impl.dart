import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_teller/domain/providers/theme_mode_provider.dart';

final sharedPrefs = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

final themeModeProvider =
    StateNotifierProvider<ThemeModeProviderImpl, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPrefs);
  var storedMode = ThemeMode.dark.toString();
  prefs.whenData((value) {
    storedMode = value.getString('themeMode') ?? ThemeMode.dark.toString();
  });

  var mode = ThemeMode.values.firstWhere((e) => e.toString() == storedMode);
  return ThemeModeProviderImpl(mode, prefs);
});

class ThemeModeProviderImpl extends StateNotifier<ThemeMode>
    implements ThemesProvider {
  final AsyncValue<SharedPreferences> prefs;

  ThemeModeProviderImpl(super.state, this.prefs);

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
