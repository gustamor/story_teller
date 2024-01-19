import 'package:flutter/widgets.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';


/// A customizable bottom navigation bar widget that adapts its appearance based on the platform (Android or iOS).
///
/// This widget provides a bottom navigation bar with customizable items and tap functionalities. 
/// It uses a platform-specific widget factory to create a bottom bar that conforms to the design guidelines of the target platform.
class NiceBottomBar extends StatelessWidget {
  /// The items to display in the bottom navigation bar for Material design (Android).
  final List<BottomNavigationBarItem> materialItems;

  /// The items to display in the bottom navigation bar for Cupertino design (iOS).
  final List<BottomNavigationBarItem> cupertinoItems;

  /// The index of the currently active item in the bottom navigation bar.
  final int index;

  /// The function to call when an item is tapped.
  final void Function(int) onTapFunction;

  /// Constructs a [NiceBottomBar] with the given properties.
  ///
  /// Initializes the bottom navigation bar with customizable attributes for appearance and behavior.
  NiceBottomBar({
    super.key,
    required this.index,
    required this.onTapFunction,
    required this.materialItems,
    required this.cupertinoItems,
  });

  /// A utility for selecting the appropriate widget factory based on the platform.
  final ui = selectSpecificPlatformWidgetFactory();

  /// Builds the visual structure of the bottom navigation bar widget.
  ///
  /// Constructs the bottom navigation bar using a platform-specific widget factory, ensuring the bar adheres to
  /// the design language of the target platform (Android or iOS).
  @override
  Widget build(BuildContext context) {
    return ui.navigationBottomBar(
      materialItems: materialItems, // Sets the items for Material design.
      cupertinoItems: cupertinoItems, // Sets the items for Cupertino design.
      index: index, // Sets the currently active item.
      onTapFunction: onTapFunction, // Functionality when an item is tapped.
    );
  }
}
