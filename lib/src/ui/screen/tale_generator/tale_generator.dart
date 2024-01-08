// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable, unnecessary_import

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/domain/providers/story_orchestator_provider.dart';
import 'package:story_teller/src/ui/core/providers/genres_list_provider.dart';
import 'package:story_teller/src/ui/core/providers/prompt_provider.dart';
import 'package:story_teller/src/ui/core/widgets/builders/button.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/src/ui/core/widgets/builders/text_form_field.dart';

import 'package:story_teller/src/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/src/ui/screen/tale_generator/tale.dart';
import 'package:story_teller/src/ui/themes/styles/text_styles.dart';

class TaleGeneratorScreen extends ConsumerWidget {
  static const route = "/generator_tale";

  const TaleGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresList = ref.read(genresListProvider);
    String prompt;

    FlutterNativeSplash.remove();
    final TextEditingController controller = TextEditingController();
    return SafeArea(
        child: Scaffold(
            appBar: NiceAppBar(
              leftTapFunction: () => Navigator.pushReplacementNamed(
                  context, AssistantsScreen.route),
              leftIcon: kIconClose,
              title: tr("generate_story"),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(64.h),
                  Padding(
                    padding: EdgeInsets.all(6.r),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            /*  */ child: Text(
                              tr("write_prompt"),
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ),
                          Gap(6.h),
                          NiceTextFormField(
                            onFieldSubmitFunction: (text) {
                              ref
                                  .read(promptProvider.notifier)
                                  .update((state) => state = text);
                            },
                            controller: controller,
                            maxLines: 4,
                            borderSide: 2,
                            borderRadius: 10,
                            filled: true,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            hintText: tr("generate_prompt_story_label"),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Gap(
                            16.h,
                          ),
                          Center(
                            child: NiceButton(
                              clickFunction: () {
                           
                                prompt =
                                    tr('write_a_story_about') + controller.text;
                                final story = ref.read(
                                    storyProcessOrchestratorProvider.notifier);
                                story.generateASimpleStory(prompt);
                                Navigator.pushNamed(
                                    context, TaleScreen.route);
                              },
                              isFixedSize: false,
                              height: 110.h,
                              width: 140.w,
                              text: 'Generate',
                              iosPadding: 30,
                              foregroundColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .onBackground,
                              iosBackgroundColor: const Color(0xff2b72a9),
                              androidBackgroundColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .background,
                              textStyle: TextStyle(fontSize: 21.sp),
                            ),
                          ),
                          Gap(32.h),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Text(
                                tr("choose_content_genre"),
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ),
                          ),
                          Gap(32.h),
                          Center(
                            child: Wrap(
                              spacing: 10.w,
                              runSpacing: 12.r,
                              children: genresList
                                  .map((item) => NiceButton(
                                        clickFunction: () {
                                          final prompt =
                                              tr('write_a_story_of_genre') +
                                                  tr(item);
                                          ref
                                              .read(promptProvider.notifier)
                                              .update(
                                                  (state) => state = prompt);
                                          var story = ref.read(
                                              storyProcessOrchestratorProvider
                                                  .notifier);
                                          story.generateASimpleStory(prompt);
                                          Navigator.pushReplacementNamed(
                                              context, TaleScreen.route);
                                        },
                                        text: tr(item),
                                        height: 30.h,
                                        borderSide: 0.5.r,
                                        foregroundColor: Theme.of(context)
                                            .buttonTheme
                                            .colorScheme!
                                            .onBackground,
                                        backgroundColor: Theme.of(context)
                                            .buttonTheme
                                            .colorScheme!
                                            .background,
                                        isFixedSize: false,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
