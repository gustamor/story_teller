// ignore: unnecessary_import
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AndroidAiBottomBar extends StatelessWidget {
  const AndroidAiBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: null,
      currentIndex: 1,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.book),
          label: tr("history"),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: tr('settings'),
        ),
      ],
    );
  }
}
