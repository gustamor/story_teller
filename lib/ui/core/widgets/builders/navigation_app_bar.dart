import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';

class NiceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leftIcon;
  final String? rightIcon;
  final VoidCallback? leftTapFunction;
  final VoidCallback? rightTapFunction;

  NiceAppBar({
    super.key,
    this.title,
    this.leftIcon,
    this.rightIcon,
    this.leftTapFunction,
    this.rightTapFunction, 
  });
 @override
  Size get preferredSize =>  Size.fromHeight(40.h); // Altura preferida para el app bar

  final ui = selectSpecificPlatformWidgetFactory();

  @override
  Widget build(BuildContext context) {
    return ui.navigationAppBar(
      title: title ?? "",
      leftIcon: leftIcon ?? "",
      rightIcon: rightIcon ?? "",
      leftTapFunction: leftTapFunction ?? () => {},
      rightTapFunction: rightTapFunction ?? () => {}
    );
  }
}
