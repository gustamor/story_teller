// ignore: unnecessary_import
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AndroidAiBottomBar extends StatelessWidget {
  final List<BottomNavigationBarItem> materialItems;
  final List<BottomNavigationBarItem> cupertinoItems;
  final int index;
  final VoidCallback onTapFunction;

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
      onTap: null,
      currentIndex: 1,
      // ignore: prefer_const_literals_to_create_immutables
      items: materialItems,
    );
  }
}
