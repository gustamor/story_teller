import 'package:flutter/widgets.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceBottomBar extends StatelessWidget {
  final List<BottomNavigationBarItem> materialItems;
  final List<BottomNavigationBarItem> cupertinoItems;
  final int index;
  final VoidCallback onTapFunction;

  NiceBottomBar({
    super.key,
    required this.index,
    required this.onTapFunction,
    required this.materialItems,
    required this.cupertinoItems,
  });

  final ui = uiFactory();
  @override
  Widget build(BuildContext context) {
    return ui.navigationBottomBar(
      materialItems: materialItems,
      cupertinoItems: cupertinoItems,
      index: index,
      onTapFunction: onTapFunction,
    );
  }
}
