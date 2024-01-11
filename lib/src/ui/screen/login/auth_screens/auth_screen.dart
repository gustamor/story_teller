// ignore_for_file: duplicate_import, unused_import

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:openai_dart/openai_dart.dart' as openai;
import 'package:permission_handler/permission_handler.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/api/openai/chat_message.dart';
import 'package:story_teller/src/data/sources/api/openai/dalle_image_request.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/add_user.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/actions/local_user/add_user.dart';
import 'package:story_teller/src/data/di/openai_provider.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/domain/providers/chat_orchestator_provider.dart';
import 'package:story_teller/src/domain/providers/image_orchestator_provider.dart';
import 'package:story_teller/src/domain/providers/story_orchestator_provider.dart';
import 'package:story_teller/src/ui/core/providers/registration_form_provider.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/domain/services/abstract_auth_services.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/src/ui/core/widgets/builders/button.dart';
import 'package:story_teller/src/ui/core/widgets/builders/text_form_field.dart';
import 'package:story_teller/src/ui/core/widgets/text_with_state.dart';
import 'package:story_teller/src/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_forgotten_password.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_forgotten_password.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_name.dart';
import 'package:story_teller/src/ui/themes/styles/text_styles.dart';

/// Produces the authentication screen
// ignore: must_be_immutable
class AuthScreen extends ConsumerWidget {
  AuthScreen({super.key});
  static const route = "/auth_screen";

  /// Implements a [TellLogger] instance
  final TellLogger log = LogImpl();

  /// Navigates to [route]
  void navigateTo(BuildContext context, String route) async {
    Navigator.pushNamed(context, route);
  }

  /// Validates a [String? email]. Produces a bool
  bool validateEmail(String? email) {
    if (email == null) return false;
    return EmailValidator.validate(email);
  }

  /// Validates a [String? password] with a regular expression. Produces a bool
  bool validatePassword(String password) {
    RegExp regex =
        RegExp(r'^(?=.*\d).{8,}$'); // Al menos ocho carácteres y un número
    return regex.hasMatch(password);
  }

  late bool isLogged;

  /// A GlobalKey for the form state
  final GlobalKey<FormState> _authFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();
    double height = MediaQuery.of(context).size.height;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    /// Starts a safe area
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Material(
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              return Form(
                key: _authFormkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (height > 10)
                      SizedBox(
                        child: Image.network(
                          "https://i.postimg.cc/d3QMcjFp/gustavomore-a-futuristic-city-skyline-solar-punk-city-an-exte-37b9a7c2-f4ab-4a04-8d9b-c102a9ae1e66-3.png",
                          width: double.infinity,
                          height: 272.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    const Gap(16),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      child: NiceTextFormField(
                        key: const Key("emailField"),
                        onFieldSubmitFunction: (_) {
                          //    focusEmailNode.requestFocus();
                        },
                        onTapOutSide: (e) {
                          //  focusEmailNode.unfocus();
                        },
                        controller: emailController,
                        validator: (String? email) {
                          if (!validateEmail(email!)) {
                            log.e("Enter email");
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        hintText: "Enter Email",
                        keyboardType: TextInputType.emailAddress,
                        filled: true,
                        borderRadius: 32,
                        borderSide: 3,
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const Gap(16),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      child: NiceTextFormField(
                        key: const Key("passwordField"),
                        onFieldSubmitFunction: (_) {
                          //    focusPasswordNode.requestFocus();
                        },
                        onTapOutSide: (e) {
                          //  focusPasswordNode.unfocus();
                        },
                        validator: (password) {
                          if (!validatePassword(password!)) {
                            log.e("Enter password");
                            return "At least 8 letters and 1 number";
                          }
                          return null;
                        },
                        controller: passwordController,
                        hintText: "Enter Password",
                        keyboardType: TextInputType.visiblePassword,
                        filled: true,
                        borderRadius: 32,
                        borderSide: 3,
                        obscuringCharacter: "*",
                        obscureText: true,
                        prefixIcon: const Icon(Icons.key_rounded),
                        suffixIcon: const Icon(Icons.remove_red_eye),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        PasswordForgottenScreen.route,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 36.w, top: 6.h),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            tr('forgot_my_password'),
                          ),
                        ),
                      ),
                    ),
                    NiceButton(
                      key: const Key("createAccountButton"),
                      clickFunction: () async {
                        if (_authFormkey.currentState!.validate()) {
                          await ref
                              .read(authenticationStateProvider.notifier)
                              .checkIfEmailExists(emailController.value.text);
                          await ref
                              .read(
                                authenticationStateProvider.notifier,
                              )
                              .signUp(
                                emailController.value.text,
                                passwordController.value.text,
                              );
                          ref.read(registrationFormProvider.notifier).update(
                            (state) {
                              state.email = emailController.value.text;
                              state.password = passwordController.value.text;
                              return state;
                            },
                          );
                          final isVerified = await ref
                              .read(authenticationStateProvider.notifier)
                              .checkIfUserIsVerified();
                          if (!isVerified) {
                            if (context.mounted) {
                              snackMessage(
                                  context, tr('account_created_and_verify'));
                            }
                            await ref
                                .read(authenticationStateProvider.notifier)
                                .sendEmailVerification();
                          } else {
                            if (context.mounted) {
                              Navigator.pushNamed(context, AuthName.route);
                            }
                          }
                        } else {
                          // log.d("Create account with $email and $password");
                        }
                      }, //
                      text: tr('create_account'),
                      textStyle: AndroidStyle.cardCaption,
                      height: 64,
                      width: 220,
                      padding: 16.0,
                    ), //Create Account
                    const Text(
                      "- - - - - - - - -   OR   - - - - - - - - -",
                      style: AndroidStyle.cardDescription,
                    ),
                    NiceButton(
                      key: const Key("loginButton"),
                      clickFunction: () async {
                        if (_authFormkey.currentState!.validate()) {
                          log.d("successful");
                          await ref
                              .read(
                                authenticationStateProvider.notifier,
                              )
                              .signIn(
                                emailController.value.text,
                                passwordController.value.text,
                              );
                          isLogged = await ref
                              .read(
                                authenticationStateProvider.notifier,
                              )
                              .isUserLogged();
                          if (context.mounted) {
                            if (isLogged) {
                              if (ref
                                      .read(authenticationProvider)
                                      .getDisplayName() !=
                                  null) {
                                Navigator.pushReplacementNamed(
                                    context, AssistantsScreen.route);
                              } else {
                                if (context.mounted) {
                                  Navigator.pushNamed(context, AuthName.route);
                                }
                              }
                            } else {
                              snackMessage(
                                  context, tr('enter_valid_credentials'));
                              log.d("UnSuccessfull");
                            }
                          }
                        }
                        //  passwordController.clear();
                        //  emailController.clear();
                      },
                      text: "Log in",
                      textStyle: AndroidStyle.cardCaption,
                      height: 64,
                      width: 220,
                      padding: 8.0,
                    ),
                    //Login
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
