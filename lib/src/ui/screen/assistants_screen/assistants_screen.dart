// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/di/isar_provider.dart';
import 'package:story_teller/src/domain/notifiers/auth_state_notifier.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/ui/core/providers/menus_providers.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/src/ui/core/factories/specific_platform_factory.dart';
import 'package:story_teller/src/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/src/ui/core/widgets/builders/clickable_card.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_bottom_bar.dart';

import 'package:story_teller/src/ui/screen/history/generated_content_screen.dart';
import 'package:story_teller/src/ui/screen/settings/settings_screen.dart';
import 'package:story_teller/src/ui/screen/tale_generator/tale_generator.dart';

class AssistantsScreen extends ConsumerStatefulWidget {
  static const String route = "/assistants_screen";
  const AssistantsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssistantsScreensState();
}

class _AssistantsScreensState extends ConsumerState<AssistantsScreen> {
  final ui = selectSpecificPlatformWidgetFactory();

  void onItemTapped(int index, BuildContext context, WidgetRef ref) {
    debugPrint("index of menu is : $index");
    ref.read(indexProvider.notifier).value = index;
    Navigator.pushNamed(context, kBottomItemRoutes[index]);
  }

  /// Implements a [TellLogger] instance
  final TellLogger log = LogImpl();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      ref.read(buildContextProvider.notifier).update(
            (state) => context,
          );
      ref.read(screenSizeProvider.notifier).update(
            (state) => state = Size(width, height),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authenticationProvider).getDisplayName();

    final double kLeftPaddingHomeNameText = 4.w;
    final double kTopPaddingHomeWhatCanText = 32.w;
    FlutterNativeSplash.remove();
    final contextMenu = ref.watch(contextMenuProvider);
    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          title: tr('assistants'),
          rightIcon: kIconUser,
          rightTapFunction: () {
            showContextMenu(context, contextMenu: contextMenu!);
          },
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
                      "Hola $user",
                      style: TextStyle(
                        fontSize: 28.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: kLeftPaddingHomeNameText, top: 8.h, right: 92.w),
                child: Text(
                  tr("what_can_i_do_today"),
                  style: TextStyle(
                    fontSize: 28.sp,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(12.h),
              Divider(
                height: kHeightDividerAssistant.h,
                thickness: kThicknessDividerAssistant.h,
                indent: kIndentDividerAssistant.w,
                endIndent: kIndentDividerAssistant.w,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NiceClickableCard(
                        clickFunction: () => Navigator.pushNamed(
                            context, TaleGeneratorScreen.route),
                        height: 104.h,
                        width: 300.w,
                        caption: tr("story"),
                        description: tr("story_description"),
                        decorImage: kImageCyberpunkCity,
                        fit: BoxFit.cover,
                        borderRadius: 32.0.r,
                      ),
                    ]),
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
