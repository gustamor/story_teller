import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/providers/auth_providers.dart';
import 'package:story_teller/data/providers/registration_form_provider.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/services/auth_services.dart';
import 'package:story_teller/domain/services/tell_logger.dart';
import 'package:story_teller/ui/core/widgets/builders/button.dart';
import 'package:story_teller/ui/core/widgets/builders/text_form_field.dart';

import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_forgotten_password.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_forgotten_password.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_name.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

/// Produces the authentication screen
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
    return true;
    RegExp regex =
        RegExp(r'^(?=.*\d).{8,}$'); // A menos ocho carácteres y un número
    return regex.hasMatch(password);
  }

  late bool isLogged;

  login(AuthenticationService auth) async {
    try {
      final userId = await auth.signInWithEmailAndPassword(
          "pepito@kakita.com", "12345678");

      log.i(userId);
    } catch (e) {
      log.d(e);
    }
  }

  /// A GlobalKey for the form state
  final GlobalKey<FormState> _authFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();
    double height = MediaQuery.of(context).size.height;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final focusPasswordNode = FocusNode();
    final focusEmailNode = FocusNode();


    // passwordController.value.copyWith(text: credential.email);
    // emailController.value.copyWith(text: credential.password);

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
                        onFieldSubmitFunction: (_) {
                          //    focusEmailNode.requestFocus();
                        },
                        onTapOutSide: (e) {
                          //  focusEmailNode.unfocus();
                        },
                        controller: emailController,
                        focusNode: focusEmailNode,
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
                        focusNode: focusPasswordNode,
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
                        padding:  EdgeInsets.only(
                        right: 36.w, top: 6.h
                      ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: const Text(
                            "I forgot my password",
                          ),
                        ),
                      ),
                    ),
                    NiceButton(
                      clickFunction: () async {
                        if (_authFormkey.currentState!.validate()) {
                          log.d("create account email and password are valid");
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
                            snackMessage(context,
                                "Created. Please, check your email inbox for the verification link and try again");
                            await ref
                                .read(authenticationStateProvider.notifier)
                                .sendEmailVerification();
                          } else {
                            Navigator.pushNamed(context, AuthName.route);
                          }
                        } else {
                          // log.d("Create account with $email and $password");
                        }
                      }, //
                      text: "Create account",
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
                          snackMessage(context, "Logged");
                          if (isLogged)
                            Navigator.pushReplacementNamed(
                                context, AssistantsScreen.route);
                        } else {
                          //     snackMessage(context, "Enter a valid name");
                          log.d("UnSuccessfull");
                        }
                        //  passwordController.clear();
                        //  emailController.clear();
                      },
                      //navigateTo(context, AssistantsScreen.route),
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