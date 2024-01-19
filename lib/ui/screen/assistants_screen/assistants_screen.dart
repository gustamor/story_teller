// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/sources/bbdd/firestore/actions/user/add_firestore_user.dart';
import 'package:story_teller/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/data/sources/bbdd/firestore/models/user.dart';
import 'package:story_teller/domain/notifiers/auth_state_notifier.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';
import 'package:story_teller/ui/core/date_picker.dart';
import 'package:story_teller/ui/core/providers/fetch_user_name.dart';
import 'package:story_teller/ui/core/providers/menus_providers.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/ui/core/factories/specific_platform_factory.dart';
import 'package:story_teller/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_clickable_card.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_navigation_bottom_bar.dart';
import 'package:story_teller/ui/screen/history/generated_content_screen.dart';
import 'package:story_teller/ui/screen/settings/global/settings_screen.dart';
import 'package:story_teller/ui/screen/tale_generator/tale_generator.dart';

/// A screen that displays various assistant features to the user.
///
/// This screen is part of the main navigation flow of the app and allows users to interact with different assistant functionalities.
/// It includes a customizable app bar and an interactive body with options like story generation.
class AssistantsScreen extends ConsumerStatefulWidget {
  /// The route name for navigation.
  static const String route = "/assistants_screen";

  /// Constructs a [AssistantsScreen] widget.
  const AssistantsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssistantsScreensState();
}

class _AssistantsScreensState extends ConsumerState<AssistantsScreen> {
  /// A utility for selecting the appropriate widget factory based on the platform.
  final ui = selectSpecificPlatformWidgetFactory();

  /// Handles the tap on a menu item.
  ///
  /// Updates the selected index in the provider and navigates to the corresponding route.
  void onItemTapped(int index, BuildContext context, WidgetRef ref) {
    debugPrint("index of menu is : $index");
    ref.read(indexProvider.notifier).value = index;
    Navigator.pushNamed(context, kBottomItemRoutes[index]);
  }

  /// Implements a [TellLogger] instance for logging purposes.
  final TellLogger log = LogImpl();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      // Updates the context and screen size in the providers.
      ref.read(buildContextProvider.notifier).update((state) => context);
      ref.read(screenSizeProvider.notifier).update((state) => state = Size(width, height));
    });
  }

  @override
  void didUpdateWidget(covariant AssistantsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Include any additional actions to be performed when the widget updates.
  }

  @override
  Widget build(BuildContext context) {
    String? userName;
    // Watches for the user name and updates the local variable.
    final asyncUserNameTag = ref.watch(fetchUserNameProvider);
    asyncUserNameTag.whenData((name) => userName = name);
    
    // Ensures the user is created in the backend if needed.
    createUserInBackendIfNeeded(ref);
    
    // UI constants for padding and margin.
    final double kLeftPaddingHomeNameText = 4.w;
    final double kTopPaddingHomeWhatCanText = 32.w;
    
    // Removes the native splash screen.
    FlutterNativeSplash.remove();
    
    // Watches the context menu provider.
    final contextMenu = ref.watch(contextMenuProvider);

    // The main scaffold of the AssistantsScreen.
    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          title: tr('assistants'),
          rightIcon: kIconUser,
          rightTapFunction: () {
            showContextMenu(context, contextMenu: contextMenu!);
          }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Row for the welcome message.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: kLeftPaddingHomeNameText,
                      top: kTopPaddingHomeWhatCanText,
                    ),
                    child: Text(
                      'hello_user',
                      style: TextStyle(fontSize: 28.sp),
                    ).tr(namedArgs: {"user": userName ?? ""}),
                  ),
                ],
              ),
              // Text widget for additional information or prompts.
              Padding(
                padding: EdgeInsets.only(
                  left: kLeftPaddingHomeNameText, top: 8.h, right: 92.w),
                child: Text(
                  tr("what_can_i_do_today"),
                  style: TextStyle(fontSize: 28.sp),
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
              // Row for clickable cards representing different functionalities.
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NiceClickableCard(
                      clickFunction: () => Navigator.pushNamed(context, TaleGeneratorScreen.route),
                      height: 104.h,
                      width: 300.w,
                      caption: tr("story"),
                      description: tr("story_description"),
                      decorImage: kWriteStory3,
                      fit: BoxFit.cover,
                      borderRadius: 32.0.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Bottom navigation bar with interactive items.
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

/// Ensures the user is created in the backend if not already present.
createUserInBackendIfNeeded(WidgetRef ref) {
  ref.watch(addFirestoreUserProvider);
}
