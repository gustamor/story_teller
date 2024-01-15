import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/update_firestore_user_birthdate.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/update_firestore_user_surname.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/update_firebase_user_name.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/src/ui/core/providers/date_picker_provider.dart';
import 'package:story_teller/src/ui/core/providers/fetch_user_name_and_surname.dart';
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
  late TextEditingController nameController;
  late TextEditingController surnamesController;
  late TextEditingController emailController;
  late TextEditingController birthDateController;
  TellLogger log = LogImpl();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    surnamesController = TextEditingController();
    emailController = TextEditingController();
    birthDateController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnamesController.dispose();
    emailController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fontScale = ref.watch(fontScaleNotifierProvider);
    final userAsyncValue = ref.watch(userProvider);
    final datePicker = ref.watch(datePickerProvider);

    final birthDate = ref.watch(datePickerState);
    User? currentUser;
    String? userNameTag;

    final asyncUserNameTag = ref.watch(fetchUserNameAndSurnameFromIdProvider);
    asyncUserNameTag.whenData((value) => userNameTag = value);

    return userAsyncValue.when(
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
                    settingTitleText(userNameTag ?? "", fontScale: fontScale),
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
                              _userProfileTextField(
                                  tag: currentUser?.name ?? "  ",
                                  controller: nameController,
                                  inputType: TextInputType.name,
                                  readOnly: false),
                              Gap(32.h),
                              settingsFieldCaptionText(tr('surnames')),
                              Gap(8.h),
                              _userProfileTextField(
                                  tag: currentUser?.surnames ?? " ",
                                  controller: surnamesController,
                                  inputType: TextInputType.name,
                                  readOnly: false),
                              Gap(32.h),
                              settingsFieldCaptionText(
                                tr(
                                  'email',
                                ),
                              ),
                              Gap(8.h),
                              _userProfileTextField(
                                  tag: currentUser?.email ?? " ",
                                  controller: emailController,
                                  inputType: TextInputType.emailAddress,
                                  readOnly: false),
                              Gap(32.h),
                              settingsFieldCaptionText(
                                tr(
                                  'birth_date',
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  datePicker.showDatePicker(context, ref);
                                  log.d("AAA$birthDate");
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        birthDate.toString().split(' ')[
                                            0], // Formatea la fecha como prefieras
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const Icon(Icons.calendar_today,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(16.h),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: NiceButton(
                                  text: tr(
                                    'apply',
                                  ),
                                  clickFunction: () {
                                    ref.read(updateNameFirestoreUserProvider(
                                        nameController.text));
                                    ref.read(
                                        updateSurnamesFirestoreUserProvider(
                                            surnamesController.text));
                                    ref.read(
                                        updateBirthDateFirestoreUserProvider(
                                            birthDate));
                                  },
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
        log.d(error.toString());
        log.d(stackTrace.toString());
        return Container(color: Colors.red);
      },
      loading: () {
        return Container();
      },
    );
  }
}

Widget _userProfileTextField(
    {required String tag,
    required TextEditingController controller,
    required TextInputType? inputType,
    required bool readOnly}) {
  controller.text = tag;
  return NiceTextFormField(
    onTapOutSide: (fn) {},
    onChangedFunction: () {},
    controller: controller,
    hintText: tag,
    maxLines: 1,
    filled: true,
    readOnly: readOnly,
    contentPadding: 4.r,
    borderRadius: 6.r,
    obscureText: false,
    borderSide: 1.r,
    keyboardType: inputType,
  );
}
