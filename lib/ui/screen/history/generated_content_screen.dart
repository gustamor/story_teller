// ignore_for_file: prefer_const_constructors, unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/bbdd/firestore/actions/get_tales.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/builders/navigation_bottom_bar.dart';
import 'package:story_teller/ui/core/widgets/card_expanded.dart';
import 'package:story_teller/ui/core/widgets/card_tile.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/settings/settings_screen.dart';

class GeneratedContentScreen extends ConsumerWidget {
  static const String route = "/generated_content";

  GeneratedContentScreen({super.key});

  final List<String> routes = [
    GeneratedContentScreen.route,
    AssistantsScreen.route,
    SettingsScreen.route
  ];

  void onItemTapped(int index, BuildContext context, WidgetRef ref) {
    debugPrint("index of menu is : $index");

    ref.read(indexProvider.notifier).value = index;
    Navigator.pushNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();

    final materialItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.star),
        label: tr("history"),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.book),
        label: tr('assistants'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        label: tr('settings'),
      ),
    ];
    final cupertinoItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.star_fill),
        label: tr('history'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.book),
        label: tr('assistans'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.settings),
        label: tr('settings'),
      ),
    ];

    final stories = ref.watch(getTalesProvider.future);

    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          title: tr('library'),
          // leftIcon: kIconBackArrow,
          // leftTapFunction: () => Navigator.pushNamed(context, AuthName.route,),
        ),
        body: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ExpandableNotifier(
                  child: ExpandableTheme(
                    data: const ExpandableThemeData(
                      iconColor: Colors.red,
                      useInkWell: true,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: false,
                      tapBodyToExpand: true,
                      tapHeaderToExpand: true,
                      animationDuration: Duration(
                        milliseconds: 300,
                      ),
                    ),
                    child: FutureBuilder<List<Story>>(
                        future: stories,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                                width: double.infinity,
                                child:
                                    CircularProgressIndicator()); // Mostrar un indicador de carga
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // Aquí construyes tu lista basada en los datos
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.data![index];
                                Widget card;
                                if (index < 0) {
                                  card = CardExpanded(
                                      title: item.title!,
                                      storyBody: item.text!,
                                      imageUrl: item.imageUrl!,
                                      author: item.user);
                                } else {
                                  card = CardTile(
                                      title: item.title!,
                                      storyBody: item.text!,
                                      imageUrl: item.imageUrl!,
                                      author: item.user);
                                }
                                return card;
                              },
                            );
                          } else {
                            return Text('No hay datos disponibles');
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: NiceBottomBar(
          index: ref.watch(indexProvider),
          onTapFunction: (index) => onItemTapped(index, context, ref),
          materialItems: materialItems,
          cupertinoItems: cupertinoItems,
        ),
      ),
    );
  }
}
