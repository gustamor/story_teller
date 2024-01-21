// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/network/api/firestore/model/simple_story.dart';
import 'package:story_teller/data/network/api/firestore/tale/get_a_tale.dart';

import 'package:story_teller/domain/providers/auth_providers.dart';
import 'package:story_teller/ui/core/providers/current_tale_id_provider.dart';
import 'package:story_teller/ui/core/providers/fetch_user_name_and_surname.dart';
import 'package:story_teller/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/ui/core/widgets/builders/builder_navigation_app_bar.dart';

class TaleFromHistoryScreen extends ConsumerStatefulWidget {
  static const route = "/tale_from_history";

  const TaleFromHistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaleFromHistoryScreenState();
}


class _TaleFromHistoryScreenState extends ConsumerState<TaleFromHistoryScreen> {
  void navigateTo(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    String title = "";
    return SafeArea(
      child: Scaffold(
        appBar: NiceAppBar(
          leftIcon: kIconClose,
          leftTapFunction: () => Navigator.pop(context),
          title: title,
        ),
        body: Builder(
          builder: (context) {
            final taleId = ref.watch(taleToShowProvider.notifier).state;
            var story = ref.watch(getFirebaseTaleProvider(taleId));
            return story.when(
              data: (tale) {
                title = tale.title ?? "";
                return showOnCompleted(context, ref, tale);
              },
              loading: () => const Center(child: CupertinoActivityIndicator()),
              error: (e, st) => Text('Error: $e'),
            );
          },
        ),
      ),
    );
  }
}

Widget showOnCompleted(BuildContext context, WidgetRef ref, Story story) {
  double width = MediaQuery.of(context).size.width;
  String? userNameTag;
  final fontScale = ref.watch(fontScaleNotifierProvider);

  final asyncUserNameTag = ref.watch(fetchUserNameAndSurnameFromIdProvider);
  asyncUserNameTag.whenData((value) => userNameTag = value);
  String prompt = story.prompt ?? "";

  return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: SingleChildScrollView(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250.h,
                    child: (story.imageUrl != null)
                        ? CachedNetworkImage(
                            imageUrl: story.imageUrl ?? "",
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const SizedBox(),
                  ),
                  Gap(8.h),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(160.r),
                            child: Image.asset(
                              kSplashLogo,
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap(8.w),
                        Padding(
                          padding: EdgeInsets.only(top: 16.h, left: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 210.w),
                                child: storyTitleText(
                                  story.title ?? "",
                                  fontScale:
                                     fontScale,
                                ),
                              ),
                              Gap(8.h),
                              storyAuthorNameText(
                                "$userNameTag",
                                fontScale: fontScale ,
                              ),
                              Gap(12.h),
                              storyAuthorNameText(
                                DateFormat('dd MMMM, yyyy').format(story.date!),
                                fontScale: fontScale,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                Gap(12.h),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DottedBorder(
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8.r),
                      padding: const EdgeInsets.all(0),
                      color: const Color.fromRGBO(128, 67, 54, 1),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 8.h,
                            bottom: 8.h,
                          ),
                          child: storyPromptText(
                            prompt,
                            fontScale: ref.watch(fontScaleNotifierProvider),
                          ),
                        ),
                      ),
                    ),
                  ),
                   Gap(16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: storyBodyText(
                      story.text ?? "",
                      fontScale: ref.watch(fontScaleNotifierProvider),
                    ),
                  ),
                  Gap(
                    32.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          24.r,
                        ),
                        child: const Icon(CupertinoIcons.share),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          24.r,
                        ),
                        child: const Icon(CupertinoIcons.waveform),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    ),
  );
}
