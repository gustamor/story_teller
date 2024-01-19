import 'package:android_intent_plus/android_intent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_button.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  /// The route name for navigation.
  static const route = "/about_us";

  /// Constructs a [RateUsScreen] widget.
  const AboutUsScreen({super.key});

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // No app bar is used for this screen.
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(24.h), // Provides vertical spacing.
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  // Tapping the icon pops the current screen off the navigation stack, effectively closing the screen.
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.r),
                    child: const Icon(CupertinoIcons
                        .clear), // An icon for closing or canceling the action.
                  ),
                ),
              ),
              Gap(12.h), // Provides vertical spacing.
              // Displays an image representing the rating or review action.
              Image.asset(
                kImageCrew,
                height: 254.h,
                fit: BoxFit.cover,
              ),
              // Text prompting the user to rate the app.
              Gap(24.h),
              storyTitleText(tr("about_us_mays"), fontScale: 1.6),
              // Additional text providing context or encouraging the user to provide feedback.
              Gap(24.h),
              
              Padding(
                padding:  EdgeInsets.only(left:6.w, right: 6.w, bottom: 12.h),
                child: storyBodyText(
                  tr("who_we_are"),
                  fontScale: 1.2,
                ),
              ),
              Gap(12.h), // Provides vertical spacing.
              
              // Row containing a button for submitting the rating or sharing feedback.
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: NiceButton(
                            text: tr("email_us"),
                            clickFunction: () {
                              _launchURL("gustavo.pinebox@gmail.com",
                                  "tema", "body");
                            })),
                  ),
                ],
              ),
              Gap(30.h)
            ],
          ),
        ),
      ),
    );
  }
}
