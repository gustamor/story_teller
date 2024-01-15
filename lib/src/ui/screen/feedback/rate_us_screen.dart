import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/ui/core/widgets/builders/button.dart';
import 'package:story_teller/src/ui/themes/styles/text_styles.dart';

class RateUsScreen extends StatelessWidget {
  static const route = "/rate_us";
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(24.h),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.only(top:8.r),
                    child: const Icon(CupertinoIcons.clear),
                  )),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(
                    12.h,
                  ),
                  Image.asset(
                    kImageReview,
                    height: 254.h,
                    fit: BoxFit.cover,
                  ),
                  Text(tr("rate_us_mays"), style: AndroidStyle.cardCaption),
                  Text(
                    tr("your_comments_matter"),
                    style: AndroidStyle.cardDescription,
                  ),
                  Gap(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
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
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 42.w,
                        ),
                        child: NiceButton(
                            text: tr("share"), clickFunction: () => {}),
                      )),
                    ],
                  ),
                  Gap(30.h)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
