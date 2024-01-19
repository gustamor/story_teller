// ignore: unused_import
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_navigation_bar.dart';

/// A bottom navigation bar tailored for iOS platforms, adhering to Cupertino design guidelines.
///
/// This class provides a bottom navigation bar with customizable items and tap handling,
/// styled according to iOS design principles. It implements the [AbstractAiNavigationBar]
/// for consistency across different platform-specific bottom bar implementations.
class IosAiBottomBar extends StatelessWidget implements AbstractAiNavigationBar {
  @override
  final List<BottomNavigationBarItem> materialItems;
  @override
  final List<BottomNavigationBarItem> cupertinoItems;
  @override
  final int index;
  @override
  final void Function(int) onTapFunction;

  /// Constructs an [IosAiBottomBar].
  ///
  /// - Parameters:
  ///   - `cupertinoItems`: The items to display in the bottom navigation bar for Cupertino design.
  ///   - `index`: The index of the currently active bottom navigation bar item.
  ///   - `onTapFunction`: The function to execute when a bottom navigation bar item is tapped.
  ///   - `materialItems`: The items for Material design, currently unused in iOS context.
  const IosAiBottomBar({
    super.key,
    required this.materialItems,
    required this.index,
    required this.onTapFunction,
    required this.cupertinoItems,
  });

  @override
  Widget build(BuildContext context) {
    // Constructs the UI of the Cupertino-styled bottom navigation bar
    return CupertinoTabBar(
      onTap: onTapFunction,
      items: cupertinoItems,
      currentIndex: index,
    );
  }
}
