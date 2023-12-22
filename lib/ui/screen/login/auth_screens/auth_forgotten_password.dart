// ignore_for_file: unnecessary_import

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/providers/auth_providers.dart';
import 'package:story_teller/ui/core/widgets/builders/button.dart';
import 'package:story_teller/ui/core/widgets/builders/navigation_app_bar.dart';
import 'package:story_teller/ui/core/widgets/builders/text_form_field.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class PasswordForgottenScreen extends ConsumerWidget {
  static const route = "/forgotten_password";
  PasswordForgottenScreen({super.key});
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final focusEmailNode = FocusNode();
    bool validateEmail(String? email) {
      if (email == null) return false;
      return EmailValidator.validate(
        email,
      );
    }

    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: NiceAppBar(
            leftIcon: kIconClose,
            leftTapFunction: () => Navigator.pop(context),

          ),
          body: Material(
            child: SingleChildScrollView(
              child: LayoutBuilder(builder: (context, constraints) {
                return Form(
                  key: _forgotPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 128.h,
                      ),
                      const Text(
                        "Introduce el email con el que te registraste",
                        style: AndroidStyle.cardDescription,
                      ),
                      const Gap(16),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                        ),
                        child: NiceTextFormField(
                          onFieldSubmitFunction: (_) {},
                          onTapOutSide: (e) {},
                          controller: emailController,
                          focusNode: focusEmailNode,
                          validator: (String? email) {
                            if (validateEmail(email!)) {
                              // log.e("Enter email");
                              return "Please enter valid email";
                            }
                            //return null;
                          },
                          hintText: "Enter Email",
                          keyboardType: TextInputType.emailAddress,
                          filled: true,
                          borderRadius: 32,
                          borderSide: 3,
                          prefixIcon: const Icon(Icons.mail_outline),
                        ),
                      ),
                      Gap(16.h),
                      NiceButton(
                        clickFunction: () async {
                          if (validateEmail(emailController.value.text) ==
                              true) {
                            ref
                                .read(authenticationStateProvider.notifier)
                                .sendPasswordResetEmail(
                                    emailController.value.text);
                            snackMessage(context, "Reset link submitted");
                          }
                        },
                        //navigateTo(context, AssistantsScreen.route),
                        text: "Reset",
                        textStyle: AndroidStyle.cardCaption,
                        height: 64,
                        width: 220,
                        padding: 8.0,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ));
  }
}
