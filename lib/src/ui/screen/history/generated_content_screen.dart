// ignore_for_file: prefer_const_constructors, unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/tale/get_tales.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/src/ui/core/providers/fetch_user_name_and_surname.dart';
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
    String? userNameTag;

    final asyncStories = ref.watch(getTalesProvider);
    final asyncUserNameTag = ref.watch(fetchUserNameAndSurnameFromIdProvider);
    asyncUserNameTag.whenData((value) => userNameTag = value);
    return asyncStories.when(
      data: (stories) {
        return SafeArea(
          child: Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 212.h,
                shadowColor: Theme.of(context).appBarTheme.shadowColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    tr('your_tales'),
                    style: TextStyle(
                      fontSize: 20,
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  background: Image.asset(kImageBooks, fit: BoxFit.cover),
                ),
              ),
              SliverToBoxAdapter(
                child:                   
                    Gap(12.h),
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
                      child: Builder(
                        builder: (context) {
                          final item = stories[index];
                          Widget card;
                          if (index < kNumberOfExpandedCards) {
                            card = CardExpanded(
                                 uuid: item.uuid!,
                              title: item.title ?? " ",
                              storyBody: item.text ?? " ",
                                imageUrl: item.imageUrl!,
                                date: DateFormat('dd MMMM, yyyy')
                                    .format(item.date!),
                                author: userNameTag ?? " ");
                          } else {
                            card = CardTile(
                              uuid: item.uuid!,
                              title: item.title ?? " ",
                              storyBody: item.text ?? " ",
                              imageUrl: item.imageUrl,
                              author: userNameTag ?? "",
                            );
                          }
                          return card;
                        },
                      ),
                    );
                  },
                  childCount: stories.length,
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
      },
      error: (error, stackTrace) {
        return SizedBox();
      },
      loading: () {
        return SizedBox();
      },
    );
  }
}
