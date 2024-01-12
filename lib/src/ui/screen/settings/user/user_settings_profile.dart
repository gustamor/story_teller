import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/src/ui/core/widgets/builders/button.dart';
import 'package:story_teller/src/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/src/ui/core/widgets/builders/text_form_field.dart';

class UserSettingsProfileScreen extends ConsumerStatefulWidget {
  static const route = '/user_settings_profile';
  const UserSettingsProfileScreen({super.key});

  @override
  ConsumerState<UserSettingsProfileScreen> createState() =>
      _UserSettingsProfileScreenState();
}

class _UserSettingsProfileScreenState
    extends ConsumerState<UserSettingsProfileScreen> {
  late double fontScale;

  TellLogger log = LogImpl();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fontScale = ref.watch(fontScaleNotifierProvider);
    ref.read(fontScaleNotifierProvider.notifier).loadFontScale();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController surnamesController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController birthDateController = TextEditingController();
    final userAsyncValue = ref.read(userProvider);
    User? currentUser;
    userAsyncValue.when(
      data: (data) {
        currentUser = data;

        return SafeArea(
          child: Scaffold(
            appBar: NiceAppBar(
              leftIcon: kIconBackArrow,
              leftTapFunction: () => Navigator.pop(context),
              title: tr('profile'),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(48.h),
                    ClipOval(
                      child: Container(
                        width: 100.0, // Ancho del avatar
                        height: 100.0, // Altura del avatar
                        decoration: const BoxDecoration(
                          color: CupertinoColors
                              .systemGrey, // Color de fondo, puedes ajustarlo
                          image: DecorationImage(
                            image: NetworkImage(
                              kImageFace,
                            ), // URL de tu imagen
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Gap(12.h),
                    settingTitleText("Gustavo Moreno", fontScale: fontScale),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(32.h),
                              settingsFieldCaptionText(
                                tr(
                                  'name',
                                ),
                              ),
                              Gap(8.h),
                              _userProfileTextField(currentUser?.name ?? "  ",
                                  nameController, TextInputType.name),
                              Gap(32.h),
                              settingsFieldCaptionText(tr('surnames')),
                              Gap(8.h),
                              _userProfileTextField("Moreno Fernadaz",
                                  surnamesController, TextInputType.name),
                              Gap(32.h),
                              settingsFieldCaptionText(
                                tr(
                                  'email',
                                ),
                              ),
                              Gap(8.h),
                              _userProfileTextField("assa@adasds.com",
                                  emailController, TextInputType.emailAddress),
                              Gap(32.h),
                              settingsFieldCaptionText(
                                tr(
                                  'birth_date',
                                ),
                              ),
                              _userProfileTextField("12 ago 1998",
                                  birthDateController, TextInputType.datetime),
                              Gap(16.h),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: NiceButton(
                                  text: "Apply",
                                  clickFunction: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        log.d(stackTrace.toString());
        return  Container(color:Colors.red);
      },
      loading: () {
        return  Container(color:Colors.green);
      },
    );
       log.d("e");
        return  Container(color:Colors.blue);
  }
}

Widget _userProfileTextField(
    String tag, TextEditingController controller, TextInputType inputType) {
  return NiceTextFormField(
    onTapOutSide: (fn) {},
    onChangedFunction: () {},
    controller: controller,
    hintText: tag,
    maxLines: 1,
    filled: true,
    contentPadding: 4.r,
    borderRadius: 6.r,
    obscureText: false,
    borderSide: 1.r,
    keyboardType: inputType,
  );
}
