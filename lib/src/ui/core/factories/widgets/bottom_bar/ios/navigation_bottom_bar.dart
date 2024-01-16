// ignore: unused_import
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class IosAiBottomBar extends StatelessWidget {
  final List<BottomNavigationBarItem> materialItems;
  final List<BottomNavigationBarItem> cupertinoItems;
  final int index;
  final void Function(int) onTapFunction;

  const IosAiBottomBar({
    super.key,
    required this.materialItems,
    required this.index,
    required this.onTapFunction,
    required this.cupertinoItems,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      onTap: onTapFunction,
      items: cupertinoItems,
      currentIndex: index,
    );
  }
}
