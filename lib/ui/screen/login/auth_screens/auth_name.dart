import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';
import 'package:story_teller/ui/core/providers/registration_form_provider.dart';
import 'package:story_teller/ui/core/widgets/builders/button.dart';
import 'package:story_teller/ui/core/widgets/builders/text_form_field.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class AuthName extends ConsumerWidget {
  const AuthName({super.key});

  static const route = "/auth_name";

  void navigateTo(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();

    /// A GlobalKey for the form state
    final GlobalKey<FormState> nameFormkey = GlobalKey<FormState>();
    final nameController = TextEditingController();

    return SafeArea(
      child: Material(
        child: Scaffold(
          appBar: null,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0).r,
                    child: const Icon(
                      CupertinoIcons.clear,
                    ),
                  ),
                ),
                SizedBox(
                  height: 128.h,
                ),
                Form(
                  key: nameFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dinos el nombre por el que quieres te llamemos",
                        style: AndroidStyle.cardDescription,
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 48.w,
                        ),
                        child: NiceTextFormField(
                          validator: (p0) {
                            return;
                          },
                          controller: nameController,
                          hintText: tr("name"),
                          filled: true,
                          borderRadius: 30,
                          borderSide: 3,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      NiceButton(
                        clickFunction: () async {
                          if (nameController.value.text.isNotEmpty) {
                            ref.read(registrationFormProvider.notifier).update(
                              (state) {
                                state.userName = nameController.value.text;
                                state.acceptedTerms = true;
                                return state;
                              },
                            );
                         
                            final user = ref.read(authenticationStateProvider);
                            if (user?.emailVerified == false) {
                              snackMessage(context,
                                  "Please, check your email inbox for the verification link and try again");
                              const Center(
                                  child: Text(
                                      "Please, check your email inbox for the verification link"));
                            }
                          } else {
                            snackMessage(context, "Enter a valid name ");
                          }
                        },
                        text: tr('enter_to_story_teller'),
                        textStyle: AndroidStyle.cardCaption,
                        height: 64,
                        width: 220,
                        padding: 16.0,
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
