// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/domain/widgets/ai_clickable_card.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class IosClickableCard extends StatelessWidget implements AiClickableCard {
  final double? height;
  final double? width;
  final String? decorImage;
  final BoxFit? fit;
  final double? borderRadius;
  final String? caption;
  final String? description;
  final String? textStyle;

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
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 1,
        shadowColor: const Color(0x00000000),
        color: const Color(0xFF000000),
        child: Padding(
          padding: const EdgeInsets.only(left:8.0, top: 0.0),
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
                    Container(
                      height: height,
                      width: 76.w,
                      color: const Color(0xFF000000),
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
