import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/widgets/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/button.dart';
import 'package:story_teller/ui/core/widgets/text_form_field.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/tale_generator/tale.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class TaleGeneratorScreen extends StatelessWidget {
  static const route = "/generator_tale";

  const TaleGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return SafeArea(
        child: Scaffold(
            appBar: null,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NiceAppBar(
                    leftTapFunction: () => Navigator.pushReplacementNamed(
                        context, AssistantsScreen.route),
                    leftIcon: kIconBackArrow,
                    title: tr("assistants"),
                  ),
                  Gap(64.h),
                  Padding(
                    padding: EdgeInsets.all(6.r),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        /*  */    child: Text(
                              tr("write_prompt"),
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ),
                          NiceTextFormField(
                            maxLines: 4,
                            borderSide: 2,
                            borderRadius: 10,
                            filled: true,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            hintText: tr("generate_prompt_story_label"),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Text(
                              tr("choose_content_genre"),
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ),
                       Gap( 24.h,
                          ),
                          Wrap(
                            spacing: 3.w,
                            runSpacing: 3.r,
                            children: [
                              NiceButton(
                                clickFunction: () => {},
                                text: "Fantasia",
                                textStyle: AndroidStyle.cardCaption,
                                height: 30.h,
                                isFixedSize: false,
                              ),
                              Gap(6.w),
                              NiceButton(
                                clickFunction: () => {},
                                text: "Naves espaciales",
                                textStyle: AndroidStyle.cardCaption,
                                height: 30.h,
                                isFixedSize: false,
                              ),
                              Gap(6.w),
                              NiceButton(
                                clickFunction: () => {},
                                text: "Naves espaciales",
                                textStyle: AndroidStyle.cardCaption,
                                height: 30.h,
                                isFixedSize: false,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  NiceButton(
                    clickFunction: () => {},
                    height: 48.h,
                    width: 200.w,
                    text: 'Generate',
                    backgroundColor: const Color(0xff2b72a9),
                    textStyle: TextStyle(fontSize: 21.sp),
                  )
                ],
              ),
            )));
  }
}
