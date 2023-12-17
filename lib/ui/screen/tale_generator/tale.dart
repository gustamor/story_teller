import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/widgets/navigation_app_bar.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class TaleScreen extends StatelessWidget {
  static const route = "/tale";

  const TaleScreen({super.key});

  void navigateTo(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          leftIcon: kIconBackArrow,
          title: tr('assistants'),
          leftTapFunction: () => navigateTo(context, AssistantsScreen.route),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  width: width - 12.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 250.h,
                        child: Image.network(
                          'https://i.postimg.cc/d3QMcjFp/gustavomore-a-futuristic-city-skyline-solar-punk-city-an-exte-37b9a7c2-f4ab-4a04-8d9b-c102a9ae1e66-3.png',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return const CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Text('Some errors occurred!'),
                        ),
                      ),
                      Gap(12.h),
                      Row(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(160.r),
                              child: Image.asset(
                                'assets/images/splash_logo.png',
                                width: 80.w,
                                height: 80.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Gap(12.w),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: Column(
                                children: [
                                  const Text(
                                    "El planeta solitario sin ojos que lo vean",
                                    style: AndroidStyle.cardCaption,
                                  ),
                                  Gap(12.h),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Por Emma Moreno Li",
                                      style: AndroidStyle.cardDescription,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Gap(16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: const Text(
                          "escribe un guión de cine de película de ciencia ficción sobre el crépusculo de los tiempos",
                          style: AndroidStyle.cardDescription,
                        ),
                      ),
                      Gap(8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "Había una vez, en el rincón más remoto del universo, un pequeño planeta solitario que flotaba en la inmensidad del espacio. Este misterioso mundo, llamado Veridion, permanecía oculto entre las estrellas, sin que nadie hubiera tenido la fortuna de descubrirlo. Su existencia era un secreto bien guardado, conocido solo por el cosmos mismo.",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      Gap(
                        32.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(24.r),
                            child: SvgPicture.asset(
                              kIconShare,
                              width: 24.w,
                              height: 24.h,
                               color: Theme.of(context).cardColor.onColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(24.r),
                            child: SvgPicture.asset(
                              kIconWave,
                              width: 32.w,
                              height: 32.h,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
