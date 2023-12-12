// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_navigation_bar.dart';

class AndroidNavigationAppBar extends StatelessWidget implements AiNavigationBar {
  final String? title;
  final String? leftIcon;
  final String? rightIcon;
  final Function? leftTapFunction;
  final Function? rightTapFunction;

  const AndroidNavigationAppBar(
      {super.key,
      this.title,
      this.leftIcon,
      this.rightIcon,
      this.leftTapFunction,
      this.rightTapFunction,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 40.h,
      width: double.infinity,
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Text("> Asistentes", style: TextStyle(fontSize: 21),),
      ),
    );
  }
}
