import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_navigation_bar.dart';

class IosNavigationAppBar extends StatelessWidget implements AiNavigationBar {
  final String? title;
  final String? leftIcon;
  final String? rightIcon;
  final Function? leftTapFunction;
  final Function? rightTapFunction;

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
      height: 35.h,
      width: double.infinity,
      child: const Row(
        children: [
          Icon(CupertinoIcons.back),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Asistentes",
              style: TextStyle(fontSize: 21),
            ),
          ),
        ],
      ),
    );
  }
}
