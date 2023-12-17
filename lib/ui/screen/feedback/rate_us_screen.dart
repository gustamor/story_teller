import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/widgets/button.dart';

class RateUsScreen extends StatelessWidget {
  static const route = "/rate_us";
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    kIconBackArrow,
                    color: Theme.of(context).primaryColor,
                    height: 16.h,
                    width: 16.w,
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
                      kImageCyberpunkCity,
                      height: 300.h,
                      fit: BoxFit.cover,
                    ),
                    Gap(
                      12.h,
                    ),
                    const Text(
                        "Valóranos, valóranos, y blablabla and blablabla"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.all(
                            3.r,
                          ),
                          child: const Icon(
                            Icons.star,
                          ),
                        ),
                      ),
                    ),
                    NiceButton(text: "Rate us", clickFunction: () => {}),
                    Gap(32.h)
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
