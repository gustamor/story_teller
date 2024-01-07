import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_clickable_card.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';


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
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(left:8.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height,
                      width: 76.w,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(160.r),
                          child: Image.network(
                            decorImage!,
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  caption!,
                  style: AndroidStyle.cardCaption,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 48.h,
                width: 154.w,
                constraints: BoxConstraints(maxWidth: 152.w),
                padding: EdgeInsets.only(left: 4.w),
                child: Text(description!, style: AndroidStyle.cardDescription),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
