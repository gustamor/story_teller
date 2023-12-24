// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/builders/navigation_bottom_bar.dart';

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
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            Widget card;
                            if (index < 2) {
                              card = Card2();
                            } else {
                              card = Card1();
                            }
                            return card;
                          })),
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

const loremIpsum =
    "Veridion era un planeta especial, lleno de maravillas únicas que ningún ojo había presenciado. Sus cielos eran un lienzo interminable de colores nunca antes vistos: tonalidades de azules que cambiaban con cada respiración del planeta, y luces que danzaban en la atmósfera como destellos de sueños. Sin embargo, la soledad de Veridion también lo envolvía como un manto, creando un aura de misterio y encanto.";

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Título de la historia",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor))),
                collapsed: const SizedBox(),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(1))
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            loremIpsum,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// ignore: use_key_in_widget_constructors
class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
          child: Image.network(
            kImageCyberpunkCity,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    buildImg2(Color color, double height) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
          child: Image.network(
            kImagePlanet,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    buildImg3(Color color, double height) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
          child: Image.network(
            kImageBookPage,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    buildImg4(Color color, double height) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
          child: Image.network(
            kImageFace,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("El dragón que durmió mil años bajo el agua del río",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("El dragón que durmió mil años bajo el agua del río",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  Text(
                    "Gustavo Moreno",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg2(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg3(Colors.lightBlue, 100)),
              Expanded(child: buildImg4(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              loremIpsum,
              softWrap: true,
            ),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var controller =
                          ExpandableController.of(context, required: true)!;
                      return TextButton(
                        child: Text(
                          controller.expanded ? "CERRAR" : "EXPANDE",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.deepPurple),
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
