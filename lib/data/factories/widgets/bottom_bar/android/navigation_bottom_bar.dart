// ignore: unnecessary_import
// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AndroidAiBottomBar extends StatelessWidget {
  final List<BottomNavigationBarItem> materialItems;
  final List<BottomNavigationBarItem> cupertinoItems;
  final int index;
  final void Function(int) onTapFunction;

  const AndroidAiBottomBar({
    super.key,
    required this.materialItems,
    required this.index,
    required this.onTapFunction,
    required this.cupertinoItems,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTapFunction,
      currentIndex: index,
      //ignore: prefer_const_literals_to_create_immutables
      items: materialItems,
    );
  }
}
