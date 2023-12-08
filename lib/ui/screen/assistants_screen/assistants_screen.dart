import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';
import 'package:story_teller/ui/core/widgets/app_bar/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/clickable_card/clickable_card.dart';

import '../../core/widgets/bottom_bar/navigation_bottom_bar.dart';

class AssistantsScreen extends StatelessWidget {
  AssistantsScreen({super.key});

  static const String tag = "/assistants";
  final ui = uiFactory();


  @override
  Widget build(BuildContext context) {
    final double kLeftPaddingHomeNameText = 4.w;
    final double kTopPaddingHomeWhatCanText = 32.w;
    FlutterNativeSplash.remove();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xdd393939),
        appBar: null ,
        body: SingleChildScrollView(
          child: Column(

            children: [
              NiceAppBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.greenAccent,
                    child: Padding(
                      padding:  EdgeInsets.only(
                        left: kLeftPaddingHomeNameText,
                        top: kTopPaddingHomeWhatCanText,
                      ),
                      child: Text(
                        "Hola User",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.sp,
                        ),
                      ),
                    ),
                  ),
                  Container(height: 50.h, width: 50.w, color: Colors.amber)
                ],
              ),
              Container(
                color: Colors.pink,
                child: Padding(
                  padding: EdgeInsets.only(left: kLeftPaddingHomeNameText, top: 8.h,
                      right: 92.w),
                  child: Text(
                    "¿Qué puedo hacer hoy por tí?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.sp,

                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,

                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NiceClickableCard(
                      height: 104.h,
                      width: 112.w,
                      caption: tr("story"),
                      description: tr("story_description"),
                      decorImage: "https://i.postimg.cc/d3QMcjFp/gustavomore-a-futuristic-city-skyline-solar-punk-city-an-exte-37b9a7c2-f4ab-4a04-8d9b-c102a9ae1e66-3.png",
                      fit: BoxFit.cover,
                      borderRadius: 32.0,
                    ),
                    NiceClickableCard(
                      height: 104.h,
                      width: 112.w,
                      caption: tr("script"),
                      description: tr("script_description"),
                      decorImage: "https://i.postimg.cc/RVZK6xhn/gustavomore-httpss-mj-runa-UKbn81m-Ipo-httpss-mj-run-EAIfn64a-Lm8-209683bf-662b-49e3-b12f-e46de98790a7-3.png",
                      fit: BoxFit.cover,
                      borderRadius: 32.0,
                    ),
                  ],
                ),
              ),
          /*
              NiceButton(
                  backgroundColor: const Color(0xaa22f3ab),
                  androidBackgroundColor: Colors.amber,
                  iosBackgroundColor: const Color(
                    0xFF0033d3,
                  ),
                  iosPadding: 8.r,
                  androidPadding: 8.r),*/
            ],
          ),
        ),
        bottomNavigationBar: NiceBottomBar(),
      ),
    );
  }
}
