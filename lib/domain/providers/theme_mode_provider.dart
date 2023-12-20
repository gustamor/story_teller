import 'package:flutter/material.dart';

abstract class ThemesProvider {
  void switchTheme(bool isOn);
  void changeTheme(ThemeMode mode);
}
