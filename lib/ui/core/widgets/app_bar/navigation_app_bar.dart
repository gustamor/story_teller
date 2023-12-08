import 'package:flutter/material.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceAppBar extends StatelessWidget {
  final String? title;
  final String? leftIcon;
  final String? rightIcon;
  final Function? leftTapFunction;
  final Function? rightTapFunction;

  NiceAppBar({
    super.key,
    this.title,
    this.leftIcon,
    this.rightIcon,
    this.leftTapFunction,
    this.rightTapFunction,
  });

  final ui = uiFactory();

  @override
  Widget build(BuildContext context) {
    return ui.navigationAppBar(
      title: title,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      leftTapFunction: leftTapFunction,
      rightTapFunction: rightTapFunction,
    );
  }
}
