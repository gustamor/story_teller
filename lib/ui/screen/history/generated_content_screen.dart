import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/widgets/app_bar/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/bottom_bar/navigation_bottom_bar.dart';
import 'package:story_teller/ui/screen/login/auth_screen/auth_name.dart';

class GeneratedContentScreen extends StatelessWidget {
  static const String route = "/generated_content";

  const GeneratedContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          height: double.infinity,
          child: Column(
            children: [
              NiceAppBar(
                title: "Generated",
                leftIcon: kIconBackArrow,
                leftTapFunction: () => Navigator.pushNamed(context, AuthName.route),
              ),
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
        bottomNavigationBar: NiceBottomBar(),
      ),
    );
  }
}

const loremIpsum =
"Veridion era un planeta especial, lleno de maravillas únicas que ningún ojo había presenciado. Sus cielos eran un lienzo interminable de colores nunca antes vistos: tonalidades de azules que cambiaban con cada respiración del planeta, y luces que danzaban en la atmósfera como destellos de sueños. Sin embargo, la soledad de Veridion también lo envolvía como un manto, creando un aura de misterio y encanto.";
class Card1 extends StatelessWidget {
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
                decoration: BoxDecoration(
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
                    padding: EdgeInsets.all(10),
                    child: Text("Título de la historia",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor))),
                collapsed: SizedBox(),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(1))
                      Padding(
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
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
            kImageFace,
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
            kImageCyberpunkCity,
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
              padding: EdgeInsets.all(10),
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
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("El dragón que durmió mil años bajo el agua del río",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  Text(
                    "Gustavo Moreno",
                    style: Theme.of(context).textTheme.caption,
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
      return Padding(
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
              Divider(
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
                              .button!
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
