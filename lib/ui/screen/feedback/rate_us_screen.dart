import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_button.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

/// A screen that allows users to rate the app and provide feedback.
///
/// This screen presents an interface for the user to rate the app, typically with stars, and possibly submit comments or feedback.
/// It includes a visual representation of the rating component and a call to action for sharing feedback.
class RateUsScreen extends StatelessWidget {
  /// The route name for navigation.
  static const route = "/rate_us";

  /// Constructs a [RateUsScreen] widget.
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // No app bar is used for this screen.
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.r),
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
                  child: const Icon(CupertinoIcons.clear), // An icon for closing or canceling the action.
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(12.h), // Provides vertical spacing.
                  // Displays an image representing the rating or review action.
                  Image.asset(
                    kImageReview,
                    height: 254.h,
                    fit: BoxFit.cover,
                  ),
                  // Text prompting the user to rate the app.
                  Text(tr("rate_us_mays"), style: AndroidStyle.cardCaption),
                  // Additional text providing context or encouraging the user to provide feedback.
                  Text(
                    tr("your_comments_matter"),
                    style: AndroidStyle.cardDescription,
                  ),
                  Gap(12.h), // Provides vertical spacing.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      // Generates star icons for the rating. The number of filled or highlighted stars can be dynamic based on the user's rating.
                      return Expanded(
                        child: SvgPicture.asset(
                          kIconStarFilled,
                          color: (index < 4) ? Colors.yellow : Colors.grey,
                          height: 42.h,
                          width: 42.w,
                        ),
                      );
                    }),
                  ),
                  // Row containing a button for submitting the rating or sharing feedback.
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 42.w),
                          child: NiceButton(
                            text: tr("share"),
                            clickFunction: () => {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(30.h) // Provides vertical spacing.
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
