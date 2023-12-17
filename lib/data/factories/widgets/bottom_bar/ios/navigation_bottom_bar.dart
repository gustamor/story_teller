import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class IosAiBottomBar extends StatelessWidget {
  const IosAiBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.star_fill),
          label: tr('history'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.settings),
          label: tr('settings'),
        ),

      ],
    );
  }
}
