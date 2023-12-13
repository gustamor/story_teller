import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/domain/widgets/ai_navigation_bar.dart';

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
      color: Colors.red,
      height: 40.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: leftTapFunction!,
              child: Row(
                children: [
                  SvgPicture.asset(
                    leftIcon!,
                    width: 16.w,
                    height: 16.h,
                  ),
                  Gap(6.w),
                  Text(
                    title!,
                    style: const TextStyle(fontSize: 21),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
