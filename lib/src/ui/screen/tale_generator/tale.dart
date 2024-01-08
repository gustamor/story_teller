// ignore_for_file: unused_import

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/get_a_tale.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/actions/tales/get_tale_provider.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/models/tale.dart';

import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/domain/providers/story_orchestator_provider.dart';
import 'package:story_teller/src/domain/story_process_state.dart';
import 'package:story_teller/src/ui/core/providers/current_tale_id_provider.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/src/ui/core/providers/prompt_provider.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/src/ui/screen/assistants_screen/assistants_screen.dart';

class TaleScreen extends ConsumerWidget {
  static const route = "/tale";

  const TaleScreen({super.key});

  void navigateTo(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();

    final notifications = ref.watch(storyProcessOrchestratorProvider);

    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          leftIcon: kIconClose,
          leftTapFunction: () => Navigator.pop(context),
        ),
        body: Builder(
          builder: (context) {
            final step = notifications.step;

            switch (step) {
              case StoryProcessStep.starting:
              case StoryProcessStep.generatingStory:
                return onLoading(context, "Creando la historia", Colors.yellow);
              case StoryProcessStep.storyCompleted:
                return onLoading(context, "Historia completa", Colors.green);
              case StoryProcessStep.generatingImage:
              case StoryProcessStep.savingImage:
                return onLoading(context, "Generando la imagen", Colors.orange);
              case StoryProcessStep.imageCompleted:
                final taleId = ref.watch(taleToShowProvider.notifier).state;
                var story = ref.watch(getTaleProvider(taleId));
                return story.when(
                  data: (tale) {
                    
                    return showOnCompleted(context, ref, tale);
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, st) => Text('Error: $e'),
                );

              case StoryProcessStep.error:
                return onLoading(context, "Hubo algún error", Colors.red);

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

Widget onLoading(BuildContext? context, String text, Color color) {
  return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            color: color,
            radius: 16.r,
          ),
          Gap(8.h),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      )));
}

Widget showOnCompleted(BuildContext context, WidgetRef ref, Tale? story) {
  double width = MediaQuery.of(context).size.width;
  var prompt = ref.watch(promptProvider);
  var displayName = ref.watch(authenticationProvider).getDisplayName();
  return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: SingleChildScrollView(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 3.h,
          ),
          SizedBox(
            width: width - 12.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250.h,
                  child:  (story!.imageUrl != null) ? Image.network(
                    story.imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Some errors occurred!'),
                  ): const SizedBox()
                ),
                Gap(12.h),
                Row(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(160.r),
                        child: Image.asset(
                          'assets/images/splash_logo.png',
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gap(8.w),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, left: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          storyTitleText(
                            story.title!,
                            fontScale: ref.watch(fontScaleNotifierProvider),
                          ),
                          Gap(12.h),
                          storyAuthorNameText(
                            "$displayName",
                            fontScale: ref.watch(fontScaleNotifierProvider),
                          ),
                          Gap(12.h),
                          storyAuthorNameText(
                            DateFormat('dd MMMM, yyyy').format(story.date!),
                            fontScale: ref.watch(fontScaleNotifierProvider),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Gap(32.h),
                DottedBorder(
                  dashPattern: const [6, 3],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8.r),
                  padding: const EdgeInsets.all(0),
                  color: const Color.fromRGBO(128, 67, 54, 1),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 8.h,
                        bottom: 8.h,
                      ),
                      child: storyPromptText(
                        prompt,
                        fontScale: ref.watch(fontScaleNotifierProvider),
                      ),
                    ),
                  ),
                ),
                Gap(32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: storyBodyText(
                    story.story!,
                    fontScale: ref.watch(fontScaleNotifierProvider),
                  ),
                ),
                Gap(
                  32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24.r),
                      child: SvgPicture.asset(
                        kIconShare,
                        width: 24.w,
                        height: 24.h,
                        color: Theme.of(context).cardColor.onColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.r),
                      child: SvgPicture.asset(
                        kIconWave,
                        width: 32.w,
                        height: 32.h,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
