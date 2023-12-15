
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

abstract class ThemesProvider {
  void changeTheme(bool isOn);
}