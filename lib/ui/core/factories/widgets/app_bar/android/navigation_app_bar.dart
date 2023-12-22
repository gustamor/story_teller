// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/domain/widgets/ai_navigation_bar.dart';

class AndroidNavigationAppBar extends StatelessWidget
    implements AiNavigationBar {
  final String? title;
  final String? leftIcon;
  final String? rightIcon;
  final VoidCallback? leftTapFunction;
  final VoidCallback? rightTapFunction;
  final bool? backgroundOpacity;

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
      //  height: 35.h,
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
                style:  TextStyle(fontSize: 15.sp),
              ),
            ),
          ),
          (rightIcon != null)
              ? Expanded(flex: 1, child: SvgPicture.asset(
                        rightIcon!,
                        width: 16.w,
                        height: 16.h,
                        color: Theme.of(context).appBarTheme.foregroundColor,
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
