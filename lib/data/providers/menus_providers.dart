// ignore_for_file: unnecessary_import, unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/providers/auth_providers.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_screen.dart';
import 'package:story_teller/ui/screen/settings/settings_screen.dart';

/// Provides a state management for [BuildContext].
///
/// This provider returns null initially and is intended to be updated
/// with the current BuildContext when required.
final buildContextProvider = StateProvider<BuildContext?>((ref) {
  return null;
});

/// Manages the state of the screen size.
///
/// This provider is used to track and update the screen size,
/// useful for responsive design implementations.
final screenSizeProvider = StateProvider<Size>((ref) {
  return Size(0.w, 0.h);
});

/// Provides a context menu using the current [BuildContext] and screen size.
///
/// This provider utilizes the [buildContextProvider] and [screenSizeProvider]
/// to construct a context menu with specific entries and positioning.
final contextMenuProvider = Provider<ContextMenu?>((ref) {
  final context = ref.watch(buildContextProvider);
  final size = ref.watch(screenSizeProvider);
  
  if (context == null) return null;

  final entries = <ContextMenuEntry>[
    MenuHeader(text: tr('persona')),
    MenuItem(
      label: tr('user_settings'),
      icon: CupertinoIcons.settings,
      onSelected: () {
        Navigator.pushReplacementNamed(context, SettingsScreen.route);
      },
    ),
    const MenuDivider(),
    MenuItem(
      label: tr('close_session'),
      icon: CupertinoIcons.square_arrow_left,
      onSelected: () {
        ref.read(authenticationStateProvider.notifier).signOut();
        Navigator.pushReplacementNamed(context, AuthScreen.route);
      },
    ),
  ];
  
  return ContextMenu(
    entries: entries,
    position: Offset(size.width, 64.h),
    padding: const EdgeInsets.all(8.0),
  );
});
