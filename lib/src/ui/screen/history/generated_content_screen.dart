// ignore_for_file: prefer_const_constructors, unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/tale/get_tales.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/src/ui/core/providers/history_lenght_provider.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_bottom_bar.dart';
import 'package:story_teller/src/ui/core/widgets/card_expanded.dart';
import 'package:story_teller/src/ui/core/widgets/card_tile.dart';
import 'package:story_teller/src/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/src/ui/screen/settings/global/settings_screen.dart';

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

    final stories = ref.watch(getTalesProvider.future);
    final talesLength = ref.watch(talesLengthProvider);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(tr('your_tales')),
              background: Image.network(klibraryImage, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: settingTitleText("Tales", fontScale: 1.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    endIndent: kIndentDividerAssistant,
                    thickness: kThicknessDividerAssistant,
                    indent: kThicknessDividerAssistant,
                  ),
                ),
                Gap(12.h),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ExpandableTheme(
                  data: const ExpandableThemeData(
                    iconColor: Colors.red,
                    useInkWell: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: false,
                    tapBodyToExpand: true,
                    tapHeaderToExpand: true,
                    animationDuration: Duration(
                      milliseconds: 500,
                    ),
                  ),
                  child: FutureBuilder<List<Story>>(
                    future: stories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: double.infinity,
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final item = snapshot.data![index];
                        Widget card;
                        if (index < 50) {
                          card = Expanded(
                            child: CardExpanded(
                                uuid: item.uuid!,
                                title: item.title!,
                                storyBody: item.text!,
                                imageUrl: item.imageUrl!,
                                date: DateFormat('dd MMMM, yyyy')
                                    .format(item.date!),
                                author: ref
                                    .read(authenticationProvider)
                                    .getDisplayName()),
                          );
                        } else {
                          card = CardTile(
                            uuid: item.uuid!,
                            title: item.title ?? "title null",
                            storyBody: item.text ?? "story body null",
                            imageUrl: item.imageUrl,
                            author: ref
                                    .read(
                                      authenticationProvider,
                                    )
                                    .getDisplayName() ??
                                "name null",
                          );
                        }
                        return card;
                      } else {
                        return Text('There is no data available');
                      }
                    },
                  ),
                );
              },
              childCount: talesLength,
            ),
          )
        ]),
        bottomNavigationBar: NiceBottomBar(
          index: ref.watch(indexProvider),
          onTapFunction: (index) => onItemTapped(
            index,
            context,
            ref,
          ),
          materialItems: BottomItems.materialItems,
          cupertinoItems: BottomItems.cupertinoItems,
        ),
      ),
    );
  }
}
