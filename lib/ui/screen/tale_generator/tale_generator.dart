// ignore_for_file: unused_import, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/domain/providers/story_orchestator_provider.dart';
import 'package:story_teller/ui/core/providers/genres_list_provider.dart';
import 'package:story_teller/ui/core/widgets/builders/button.dart';
import 'package:story_teller/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/builders/text_form_field.dart';

import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/tale_generator/tale.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class TaleGeneratorScreen extends ConsumerWidget {
  static const route = "/generator_tale";

  const TaleGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresList = ref.read(genresListProvider);

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
                          NiceTextFormField(
                            onFieldSubmitFunction: (text) {
                              final prompt = tr('write_a_story_about') + text;
                              var story = ref.read(
                                  storyProcessOrchestratorProvider.notifier);
                              story.generateASimpleStory(prompt ??
                                  "Crea una historia al azar que no se parezca a otras");
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
                              clickFunction: () => {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(
                                      child: Text(
                                        "Generate",
                                      ),
                                    ),
                                  ),
                                )
                              },
                              isFixedSize: false,
                              height: 110.h,
                              width: 140.w,
                              text: 'Generate',
                              iosPadding: 30,
                              iosBackgroundColor: const Color(0xff2b72a9),
                              androidBackgroundColor: Color(0xffFF8A00),
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
                                                  item;
                                          var story = ref.read(
                                              storyProcessOrchestratorProvider
                                                  .notifier);
                                          story.generateASimpleStory(prompt);
                                        },
                                        text: tr(item),
                                        textStyle: AndroidStyle.cardCaption,
                                        height: 30.h,
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
