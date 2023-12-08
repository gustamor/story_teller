import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return const CupertinoNavigationBar(
      leading: Icon(Icons.arrow_back_ios),
        middle: Text('Cupertino App'),
    );
  }
}
