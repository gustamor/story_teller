// ignore_for_file: prefer_const_constructors, unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/network/api/firestore/tale/get_tales.dart';
import 'package:story_teller/data/network/api/firestore/user/fetch_firestore_user.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';
import 'package:story_teller/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/ui/core/providers/fetch_user_name_and_surname.dart';
import 'package:story_teller/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/ui/core/providers/history_lenght_provider.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_navigation_bottom_bar.dart';
import 'package:story_teller/ui/core/widgets/widget_card_expanded.dart';
import 'package:story_teller/ui/core/widgets/widget_card_tile.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/settings/global/settings_screen.dart';

/// A screen that displays a list of generated content, such as stories, to the user.
///
/// This screen presents a customizable list of content items, each represented by either a `CardExpandedWidget` or a `CardTile`.
/// The content is loaded asynchronously and displayed in a scrollable list. The screen includes a custom app bar and a bottom navigation bar.
class GeneratedContentScreen extends ConsumerWidget {
  /// The route name for navigation.
  static const String route = "/generated_content";

  /// Constructs a [GeneratedContentScreen] widget.
  GeneratedContentScreen({super.key});

  /// The list of routes for navigation when a menu item is tapped.
  final List<String> routes = [
    GeneratedContentScreen.route,
    AssistantsScreen.route,
    SettingsScreen.route,
  ];

  /// Handles the tap on a menu item.
  ///
  /// Updates the selected index in the provider and navigates to the corresponding route.
  void onItemTapped(int index, BuildContext context, WidgetRef ref) {
    debugPrint("index of menu is : $index");
    ref.watch(indexProvider.notifier).update((state) => state = index);
    Navigator.pushNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? userNameTag;
    // Watches the providers for stories and user name.
    final asyncStories = ref.watch(getTalesProvider);
    final asyncUserNameTag = ref.watch(fetchUserNameAndSurnameFromIdProvider);
    asyncUserNameTag.whenData((value) => userNameTag = value);

    // Renders the content based on the state of the stories (data, loading, or error).
    return asyncStories.when(
      data: (stories) {
        return SafeArea(
          child: Scaffold(
            // CustomScrollView allows for a custom app bar and a list of expandable cards.
            body: CustomScrollView(slivers: <Widget>[
              // A SliverAppBar that expands and collapses as the user scrolls.
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 212.h,
                shadowColor: Theme.of(context).appBarTheme.shadowColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    tr('your_tales'), // Translatable title of the screen.
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
                  background: Image.asset(kImageBooks,
                      fit: BoxFit.cover), // Background image for the app bar.
                ),
              ),
              SliverToBoxAdapter(
                child: Gap(12.h),
              ),
              // A SliverList that displays a list of stories as expandable cards.
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // Each item in the list can be expanded or collapsed.
                    return ExpandableTheme(
                      data: const ExpandableThemeData(
                        iconColor: Colors.red,
                        useInkWell: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: false,
                        tapBodyToExpand: true,
                        tapHeaderToExpand: true,
                        animationDuration: Duration(milliseconds: 500),
                      ),
                      child: Builder(
                        builder: (context) {
                          final item = stories[index];
                          Widget card;
                          // Determines if the card should be in expanded or collapsed state based on the index.
                          if (index < kNumberOfExpandedCards) {
                            card = CardExpandedWidget(
                              uuid: item.uuid!,
                              title: item.title ?? " ",
                              storyBody: item.text ?? " ",
                              imageUrl: item.imageUrl!,
                              date: DateFormat('dd MMMM, yyyy')
                                  .format(item.date!),
                              author: userNameTag ?? " ",
                            );
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
                  childCount:
                      stories.length, // The number of items in the list.
                ),
              ),
            ]),
            // Bottom navigation bar with interactive items.
            bottomNavigationBar: NiceBottomBar(
              index: ref.watch(indexProvider),
              onTapFunction: (index) {
                if (index != ref.read(indexProvider)) {
                  onItemTapped(index, context, ref);
                }
              },
              materialItems: BottomItems.materialItems,
              cupertinoItems: BottomItems.cupertinoItems,
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        // Handles the error state.
        return SafeArea(child: Scaffold(body: Center(child: Text("error: $error"))));
      },
      loading: () {
        // Displays a loading indicator while the data is being fetched.
        return SizedBox();
      },
    );
  }
}
