// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AndroidAiBottomBar extends StatelessWidget {
  const AndroidAiBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      onTap: null,
      currentIndex: 1,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
       const BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Hisotoria',
        ),

       const  BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Recientes',
        ),
      ],
    );
  }
}
