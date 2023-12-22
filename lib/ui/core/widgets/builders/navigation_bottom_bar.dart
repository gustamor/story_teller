import 'package:flutter/widgets.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';

class NiceBottomBar extends StatelessWidget {
  final List<BottomNavigationBarItem> materialItems;
  final List<BottomNavigationBarItem> cupertinoItems;
  final int index;
  final void Function(int) onTapFunction;

  NiceBottomBar({
    super.key,
    required this.index,
    required this.onTapFunction,
    required this.materialItems,
    required this.cupertinoItems,
  });

  final ui = selectSpecificPlatformWidgetFactory();
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
