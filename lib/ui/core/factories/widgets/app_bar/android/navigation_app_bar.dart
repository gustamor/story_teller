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
      color: Theme.of(context).primaryColor,
      height: 35.h,
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
                  (leftIcon != null)
                      ? SvgPicture.asset(
                          leftIcon!,
                          width: 14.w,
                          height: 14.h,
                        )
                      : const SizedBox(),
                  (leftIcon != null) ? Gap(6.w) : const SizedBox(),
                  Text(
                    title!,
                    style: const TextStyle(fontSize: 19),
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
