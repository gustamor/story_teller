// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/domain/abstract/widgets/abstract_ai_app_bar.dart';

/// Represents a navigation app bar specifically styled for Android platforms.
///
/// This class implements the [AbstractAiAppBar] and provides a Material Design-styled
/// app bar. It supports custom title text, left and right icons, and tap actions for
/// these icons.
class AndroidNavigationAppBar extends StatelessWidget implements AbstractAiAppBar {
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

  /// Constructs an [AndroidNavigationAppBar].
  ///
  /// Accepts optional parameters for title, left and right icons, tap functions, and
  /// background opacity.
  const AndroidNavigationAppBar({
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
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: leftTapFunction!,
              child: (leftIcon != null)
                  ? SvgPicture.asset(
                      leftIcon!,
                      width: 16.w,
                      height: 16.h,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    )
                  : const SizedBox(),
            ),
          ),
          Expanded(
            flex: 7,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title!,
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ),
          (rightIcon != null)
              ? Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: rightTapFunction,
                    child: SvgPicture.asset(
                      rightIcon!,
                      width: 16.w,
                      height: 16.h,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                  ))
              : const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
        ],
      ),
    );
  }
}
