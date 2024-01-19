import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/ui/core/providers/bottom_bar_index.dart';
import 'package:story_teller/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/ui/core/providers/theme_mode_provider.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_button.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_navigation_bottom_bar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SettingsScreen extends ConsumerWidget {
  static const String route = "/settings";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onItemTapped(int index, BuildContext context, WidgetRef ref) {
      debugPrint("index of menu is : $index");
      ref.read(indexProvider.notifier).value = index;
      Navigator.pushNamed(context, kBottomItemRoutes[index]);
    }

    var value = ref.watch(fontScaleNotifierProvider);

    final Size screenSize = MediaQuery.of(context).size;
    final themeMode = ref.watch(themeModeProvider);
    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          title: tr('settings'),
        ),
        body: PreferredSize(
          preferredSize: Size(screenSize.width, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                    left: 16.w,
                  ),
                  child:  ListTile(
                    title: Text(tr("theme_mode")),
                    subtitle: Text(tr("select_light_mode")),
                    contentPadding: EdgeInsets.all(8.r),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NiceButton(
                      text: "Light",
                      borderSide: (themeMode == ThemeMode.light) ? 1 : null,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      clickFunction: () {
                        ref
                            .read(themeModeProvider.notifier)
                            .changeTheme(ThemeMode.light);
                      }),
                  Gap(8.w),
                  NiceButton(
                      text: "Night",
                      borderSide: (themeMode == ThemeMode.dark) ? 1 : null,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      clickFunction: () {
                        ref
                            .read(themeModeProvider.notifier)
                            .changeTheme(ThemeMode.dark);
                      }),
                  Gap(8.w),
                  NiceButton(
                      text: "System",
                      borderSide: (themeMode == ThemeMode.system) ? 1 : null,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      clickFunction: () {
                        ref
                            .read(themeModeProvider.notifier)
                            .changeTheme(ThemeMode.system);
                      }),
                ],
              ),
              Gap(kSettingsElementSeparator.h),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0.w, 0.h, 24.w, 0),
                child: const Divider(
                  thickness: 1,
                  height: 1,
                ),
              ),
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
                          onTap: () {
                            value = 1.0;
                            ref
                                .read(fontScaleNotifierProvider.notifier)
                                .saveFontScale(value);
                          },
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
                    GestureDetector(
                      onTap: () {},
                      child: SfSlider(
                        min: kMinFontSlider,
                        max: kMaxFontSlider,
                        value: value,
                        interval: 0.5,
                        showTicks: false,
                        showLabels: false,
                        enableTooltip: false,
                        minorTicksPerInterval: 0,
                        onChanged: (dynamic value) {
                          ref
                              .read(fontScaleNotifierProvider.notifier)
                              .saveFontScale(value.toDouble());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "${tr("example")}: ",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        tr('i_like_this_size'),
                        style: TextStyle(
                          fontSize: (15 / (1.0 / value)).sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Gap(kSettingsElementSeparator.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NiceBottomBar(
          index: ref.watch(indexProvider),
          onTapFunction: (index) => onItemTapped(index, context, ref),
          materialItems: BottomItems.materialItems,
          cupertinoItems: BottomItems.cupertinoItems,
        ),
      ),
    );
  }
}
