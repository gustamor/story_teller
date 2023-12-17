
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/providers/themes_provider.dart';

final themesProvider = StateNotifierProvider<ThemesProviderImpl, ThemeMode>((ref) {
  return ThemesProviderImpl();
});

class ThemesProviderImpl extends StateNotifier<ThemeMode> implements ThemesProvider {
  ThemesProviderImpl() : super(ThemeMode.system);

  @override
  void changeTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
  }
}

