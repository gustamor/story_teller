// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/domain/abstract/widgets/ai_clickable_card.dart';
import 'package:story_teller/src/ui/themes/styles/text_styles.dart';

class IosClickableCard extends StatelessWidget implements AiClickableCard {
  final double? height;
  final double? width;
  final String? decorImage;
  final BoxFit? fit;
  final double? borderRadius;
  final String? caption;
  final String? description;
  final String? textStyle;
  final VoidCallback? clickFunction;

  const IosClickableCard({
    super.key,
    this.height,
    this.width,
    this.decorImage,
    this.borderRadius,
    this.fit,
    this.caption,
    this.description,
    this.textStyle,
    this.clickFunction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickFunction,
      child: Card(
        elevation: 4,
         color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,
        child: Padding(
          padding:  EdgeInsets.only(left:1.w, top: 0.0),
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
                        width: 120.w,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32.r),
                            child: Image.asset(
                              decorImage!,
                              width: 120.w,
                              height: 120.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               Gap(
                 12.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  caption!,
                  style: IosStyle.cardCaption,
                ),
              ),
              Gap(
                 6.h,
              ),
              Container(
                height: 48.h,
                width: 254.w,
                constraints: BoxConstraints(maxWidth: 252.w),
                padding: EdgeInsets.only(left: 4.w),
                child: Text(description!, style: IosStyle.cardDescription),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
