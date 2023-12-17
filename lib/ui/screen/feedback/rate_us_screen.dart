import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/widgets/app_bar/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/button/button.dart';

class RateUsScreen extends StatelessWidget {
  const RateUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NiceAppBar(),
            Column(
              children: [
                Gap(
                  30.h,
                ),
                Image.network(kImageCyberpunkCity),
                Gap(
                  12.h,
                ),
                const Text(
                    "Valoranos , valoranos , y blablabla and blablabla"),
                Gap(
                  12.h,
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star,
                    ),
                  ),
                ),
                NiceButton(text: "Rate us", clickFunction: () => {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
