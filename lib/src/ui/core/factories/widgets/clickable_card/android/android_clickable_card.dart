import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/domain/abstract/widgets/ai_clickable_card.dart';

class AndroidAiClickableCard extends StatelessWidget
    implements AiClickableCard {
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? androidBackgroundColor;
  final String? decorImage;
  final String? caption;
  final String? description;
  final VoidCallback? clickFunction;
  final BoxFit? fit;
  final double? borderRadius;

  const AndroidAiClickableCard(
      {super.key,
      this.height,
      this.width,
      this.bgColor,
      this.androidBackgroundColor,
      this.caption,
      this.decorImage = "",
      this.fit,
      this.borderRadius = 16.0,
      this.description,
      this.clickFunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickFunction!,
      child: Card(
        elevation: 4,
        color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,
        child: Padding(
          padding: EdgeInsets.only(left: 1.0.w, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: height,
                        width: 112.w,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              decorImage!,
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(2.h),
                        Container(
                          padding: EdgeInsets.only(left: 4.w),
                          child: cardTitleText(
                            caption!,
                            fontScale: 0.5,
                          ),
                        ),
                        Gap(6.h),
                        Container(
                          height: 48.h,
                          width: double.infinity,
                          constraints: BoxConstraints(maxWidth: 120.w),
                          padding: EdgeInsets.only(left: 4.w),
                          child: cardBodyText(
                            description!,
                            fontScale: 0.5,
                          ),
                        ),
                      ],
                    ),
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
