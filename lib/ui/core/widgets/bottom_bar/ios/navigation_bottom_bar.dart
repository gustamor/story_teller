import 'package:flutter/cupertino.dart';

class IosAiBottomBar extends StatelessWidget {
  const IosAiBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.star_fill),
          label: 'Historia',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.star_circle_fill),
          label: 'Recents',
        ),

      ],
    );
  }
}
