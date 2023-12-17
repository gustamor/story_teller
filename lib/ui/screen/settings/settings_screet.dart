import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/widgets/button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = "/settings";
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: PreferredSize(
          preferredSize: Size(screenSize.width, 16.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 16.w,
                ),
                child: SwitchListTile(
                    title: Text("Mode"),
                    subtitle: Text("Selecciona el aspecto de la pantalla"),
                    contentPadding: const EdgeInsets.all(8),
                    value: true,
                    onChanged: (value) {}),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NiceButton(
                        text: "Light",
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        clickFunction: () {}),
                    NiceButton(
                        text: "Night",
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        clickFunction: () {}),
                    NiceButton(
                        text: "System",
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        clickFunction: () {}),
                  ],
                ),
              ),
              Gap(kSettingsElementSeparator.h),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0.w, 0.h, 24.w, 0),
                child: const Divider(
                  thickness: 1,
                  height: 1,
                ),
              ),
              Gap(
                kSettingsElementSeparator.h,
              ),
              Container( 
                margin: EdgeInsets.only(
                  left: 8.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Font Scale',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: SvgPicture.asset(
                              kIconClose,
                              color: (ThemeMode.dark == ThemeMode.dark)
                                  ? Colors.white70
                                  : Colors.black87,
                              width: 13.w,
                            ),
                          ),
                        )
                      ],
                    ),
                    Gap(10.w),
                    Padding(
                      padding: const EdgeInsets.only(left: 54.0),
                      child: SfSlider(
                        min: 0.75,
                        max: 2.1,
                        value: 0.5,
                        interval: 0.5,
                        showTicks: false,
                        showLabels: false,
                        enableTooltip: false,
                        minorTicksPerInterval: 0,
                        onChanged: (dynamic value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Example:',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Érase una vez...",
                        style: TextStyle(
                          fontSize: (16 / 0.7).sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Gap(kSettingsElementSeparator.h),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0.w, 0.h, 24.w, 0),
                      child: const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Gap(
                      kSettingsElementSeparator.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Notifications:',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
