import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';

/// A customizable app bar widget that adapts its appearance based on the platform (Android or iOS).
///
/// This widget provides a top app bar with customizable title, left and right icons, and tap functionalities. 
/// It uses a platform-specific widget factory to create an app bar that conforms to the design guidelines of the target platform.
class NiceAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text displayed in the app bar.
  final String? title;

  /// The asset name of the icon displayed on the left side of the app bar.
  final String? leftIcon;

  /// The asset name of the icon displayed on the right side of the app bar.
  final String? rightIcon;

  /// The function to call when the left icon is tapped.
  final VoidCallback? leftTapFunction;

  /// The function to call when the right icon is tapped.
  final VoidCallback? rightTapFunction;

  /// Constructs a [NiceAppBar] with the given properties.
  ///
  /// Initializes the app bar with customizable attributes for appearance and behavior.
  NiceAppBar({
    super.key,
    this.title,
    this.leftIcon,
    this.rightIcon,
    this.leftTapFunction,
    this.rightTapFunction,
  });

  /// The preferred size of the app bar, used to set its height.
  @override
  Size get preferredSize => Size.fromHeight(40.h); // Preferred height for the app bar

  /// A utility for selecting the appropriate widget factory based on the platform.
  final ui = selectSpecificPlatformWidgetFactory();

  /// Builds the visual structure of the app bar widget.
  ///
  /// Constructs the app bar using a platform-specific widget factory, ensuring the app bar adheres to
  /// the design language of the target platform (Android or iOS).
  @override
  Widget build(BuildContext context) {
    return ui.navigationAppBar(
        title: title ?? "", // Sets the title text.
        leftIcon: leftIcon ?? "", // Sets the left icon.
        rightIcon: rightIcon ?? "", // Sets the right icon.
        leftTapFunction: leftTapFunction ?? () => {}, // Functionality when left icon is tapped.
        rightTapFunction: rightTapFunction ?? () => {}); // Functionality when right icon is tapped.
  }
}
