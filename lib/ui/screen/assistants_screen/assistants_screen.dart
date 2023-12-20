import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';
import 'package:story_teller/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/ui/core/widgets/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/clickable_card.dart';
import 'package:story_teller/ui/screen/history/generated_content_screen.dart';
import 'package:story_teller/ui/screen/settings/settings_screen.dart';
import 'package:story_teller/ui/screen/tale_generator/tale_generator.dart';

import '../../core/widgets/navigation_bottom_bar.dart';

class AssistantsScreen extends ConsumerWidget {
  static const String route = "/assistants_screen";
  AssistantsScreen({super.key});

  final ui = uiFactory();

  final List<String> bottomItemRoutes = [
    GeneratedContentScreen.route,
    AssistantsScreen.route,
    SettingsScreen.route
  ];

  void onItemTapped(int index, BuildContext context, WidgetRef ref) {
    debugPrint("index of menu is : $index");
    ref.read(indexProvider.notifier).value = index;
    Navigator.pushNamed(context, bottomItemRoutes[index]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double kLeftPaddingHomeNameText = 4.w;
    final double kTopPaddingHomeWhatCanText = 32.w;
    FlutterNativeSplash.remove();

    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          title: tr('assitants'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: kLeftPaddingHomeNameText,
                      top: kTopPaddingHomeWhatCanText,
                    ),
                    child: Text(
                      "Hola User",
                      style: TextStyle(
                        fontSize: 28.sp,
                      ),
                    ),
                  ),
                  Container(height: 50.h, width: 50.w, color: Colors.amber)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: kLeftPaddingHomeNameText, top: 8.h, right: 92.w),
                child: Text(
                  "¿Qué puedo hacer hoy por tí?",
                  style: TextStyle(
                    fontSize: 28.sp,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NiceClickableCard(
                      clickFunction: () => Navigator.pushNamed(
                          context, TaleGeneratorScreen.route),
                      height: 104.h,
                      width: 112.w,
                      caption: tr("story"),
                      description: tr("story_description"),
                      decorImage: kImageCyberpunkCity,
                      fit: BoxFit.cover,
                      borderRadius: 32.0,
                    ),
                    NiceClickableCard(
                      height: 104.h,
                      width: 112.w,
                      caption: tr("script"),
                      description: tr("script_description"),
                      decorImage: kImagePlanet,
                      fit: BoxFit.cover,
                      borderRadius: 32.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NiceBottomBar(
          index: ref.watch(indexProvider),
          onTapFunction: (index) => onItemTapped(index, context, ref),
          materialItems: BottomItems.materialItems,
          cupertinoItems: BottomItems.cupertinoItems,
        ),
      ),
    );
  }
}
