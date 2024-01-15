import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/ui/core/providers/fetch_user_name_and_surname.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/src/ui/screen/feedback/rate_us_screen.dart';
import 'package:story_teller/src/ui/screen/settings/user/user_settings_profile.dart';

class UserSettingsMainScreen extends ConsumerWidget {
  static const route = "/user_settings_main";
  const UserSettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fontScale = ref.watch(fontScaleNotifierProvider);
    ref.watch(fontScaleNotifierProvider.notifier).loadFontScale();
    String? userNameTag;

    final asyncUserNameTag = ref.watch(fetchUserNameAndSurnameFromIdProvider);

    asyncUserNameTag.whenData((value) => userNameTag = value);
    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          leftTapFunction: () => Navigator.pop(context),
          leftIcon: kIconBackArrow,
          title: tr('settings'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(48.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100.0, // Ancho del avatar
                        height: 100.0, // Altura del avatar
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              kSplashLogo,
                            ), // URL de tu imagen
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 8.h,
                        ),
                        child: Flexible(
                          child: settingTitleText(
                            userNameTag ?? "",
                            fontScale: fontScale,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(42.h),
              const Divider(
                thickness: kThicknessDividerAssistant + 0.3,
                indent: kIndentDividerAssistant,
                endIndent: kIndentDividerAssistant,
              ),
              Gap(32.h),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: settingsTitleText(tr('settings')),
              ),
              Gap(16.h),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    UserSettingsProfileScreen.route,
                  );
                },
                child: ListTile(
                  leading: const Icon(CupertinoIcons.profile_circled),
                  title: Text(tr("profile")),
                  trailing: const Icon(CupertinoIcons.chevron_right),
                ),
              ),
              Gap(16.h),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell_fill),
                  title: Text(tr("notifications")),
                  trailing: const Icon(CupertinoIcons.chevron_right),
                ),
              ),
              Gap(16.h),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: const Icon(CupertinoIcons.shield_fill),
                  title: Text(tr("privacy")),
                  trailing: const Icon(CupertinoIcons.chevron_right),
                ),
              ),
              Gap(16.h),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RateUsScreen.route);
                },
                child: ListTile(
                  leading: const Icon(CupertinoIcons.star_fill),
                  title: Text(tr("rate_app")),
                  trailing: const Icon(CupertinoIcons.chevron_right),
                ),
              ),
              Gap(16.h),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: const Icon(CupertinoIcons.group_solid),
                  title: Text(tr("about_us")),
                  trailing: const Icon(CupertinoIcons.chevron_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
