import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/domain/abstract/widgets/ai_navigation_bar.dart';

class IosNavigationAppBar extends StatelessWidget implements AiNavigationBar {
  final String? title;
  final String? leftIcon;
  final String? rightIcon;
  final VoidCallback? leftTapFunction;
  final VoidCallback? rightTapFunction;


  const IosNavigationAppBar({
    super.key,
    this.title,
    this.leftIcon,
    this.rightIcon,
    this.leftTapFunction,
    this.rightTapFunction,
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
              ? Expanded(flex: 1, child: InkWell(
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
