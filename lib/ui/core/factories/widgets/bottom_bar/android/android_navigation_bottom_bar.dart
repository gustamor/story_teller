// ignore: unnecessary_import
// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_navigation_bar.dart';

/// A bottom navigation bar tailored for Android platforms, adhering to Material Design guidelines.
///
/// This class provides a bottom navigation bar with customizable items and tap handling.
/// It implements the [AbstractAiNavigationBar] for consistency across different platform-specific
/// bottom bar implementations.
class AndroidAiBottomBar extends StatelessWidget implements AbstractAiNavigationBar {
  @override
  final List<BottomNavigationBarItem> materialItems;
  @override
  final List<BottomNavigationBarItem> cupertinoItems;
  @override
  final int index;
  @override
  final void Function(int) onTapFunction;

  /// Constructs an [AndroidAiBottomBar].
  ///
  /// - Parameters:
  ///   - `materialItems`: The items to display in the bottom navigation bar for Material design.
  ///   - `index`: The index of the currently active bottom navigation bar item.
  ///   - `onTapFunction`: The function to execute when a bottom navigation bar item is tapped.
  ///   - `cupertinoItems`: The items for Cupertino design, currently unused in Android context.
  const AndroidAiBottomBar({
    super.key,
    required this.materialItems,
    required this.index,
    required this.onTapFunction,
    required this.cupertinoItems,
  });

  @override
  Widget build(BuildContext context) {
    // Constructs the UI of the bottom navigation bar
    return BottomNavigationBar(
      onTap: onTapFunction,
      currentIndex: index,
      items: materialItems,
    );
  }
}
