import 'package:easy_localization/easy_localization.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    kIconClose,
                    color: Colors.white,
                    height: 16.h,
                    width:16.w,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Gap(
                      30.h,
                    ),
                    Image.network(
                      kImageMain,
                      height: 250.h,
                      fit: BoxFit.cover,
                    ),
                     Text(tr("rate_us_mays"), style: AndroidStyle.cardCaption),
                     Text(tr("your_comments_matter"),
                      style: AndroidStyle.cardDescription,
                    ),
                    Gap(12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {

                        return Expanded(
                          child: SvgPicture.asset(
                            kIconStarFilled,
                            color: (index < 4) ? Colors.yellow: Colors.grey,
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
                              text: "Share", clickFunction: () => {}),
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
      ),
    );
  }
}
