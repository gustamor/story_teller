// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_app_bar.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_navigation_bar.dart';

/// A navigation app bar tailored for iOS platforms, adhering to iOS design guidelines.
///
/// This class provides an app bar with a title, optional left and right icons, and tap
/// actions for these icons. It implements the [AbstractAiAppBar] for consistency across
/// different platform-specific app bar implementations.
class IosNavigationAppBar extends StatelessWidget implements AbstractAiAppBar {
  @override
  final String? title;
  @override
  final String? leftIcon;
  @override
  final String? rightIcon;
  @override
  final VoidCallback? leftTapFunction;
  @override
  final VoidCallback? rightTapFunction;
  @override
  final bool? backgroundOpacity;

  /// Constructs an [IosNavigationAppBar].
  ///
  /// - Parameters:
  ///   - `title`: The title text to display in the navigation bar.
  ///   - `leftIcon`: The asset name of the icon to display on the left side of the bar.
  ///   - `rightIcon`: The asset name of the icon to display on the right side of the bar.
  ///   - `leftTapFunction`: The function to execute when the left icon is tapped.
  ///   - `rightTapFunction`: The function to execute when the right icon is tapped.
  ///   - `backgroundOpacity`: The opacity of the background. A lower value makes the bar more translucent.
  const IosNavigationAppBar({
    super.key,
    this.title,
    this.leftIcon,
    this.rightIcon,
    this.leftTapFunction,
    this.rightTapFunction,
    this.backgroundOpacity,
  });

  @override
  Widget build(BuildContext context) {
    // Constructs the UI of the app bar
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left icon or empty space if no icon is provided
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: leftTapFunction,
              child: leftIcon != null
                  ? SvgPicture.asset(
                      leftIcon!,
                      width: 16.w,
                      height: 16.h,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    )
                  : const SizedBox(),
            ),
          ),
          // Title text in the center
          Expanded(
            flex: 7,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ),
          // Right icon or empty space if no icon is provided
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: rightTapFunction,
              child: rightIcon != null
                  ? SvgPicture.asset(
                      rightIcon!,
                      width: 16.w,
                      height: 16.h,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
