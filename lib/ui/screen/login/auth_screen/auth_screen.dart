import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/providers/auth_providers.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/services/auth_services.dart';
import 'package:story_teller/domain/services/tell_logger.dart';
import 'package:story_teller/ui/core/widgets/builders/button.dart';
import 'package:story_teller/ui/core/widgets/builders/text_form_field.dart';

import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/login/auth_screen/auth_name.dart';
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

  String password = "";
  String email = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void signin() async {
      final auth = ref.watch(authenticationProvider);
      try {
        final userId = await auth.signInWithEmailAndPassword(
            "gustavo.sdasdasdasasda@gmail.com", "12345678");
        log.i("user created $userId");
      } catch (e) {
        log.e(e);
      }
    }

    FlutterNativeSplash.remove();
    double height = MediaQuery.of(context).size.height;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final focusPasswordNode = FocusNode();
    final focusEmailNode = FocusNode();

    final auth = ref.watch(firebaseAuthProvider);

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
                    NiceButton(
                      clickFunction: () {
                        if (_authFormkey.currentState!.validate()) {
                          password = passwordController.value.text;
                          email = emailController.value.text;
                          log.d("successful");
                          return;
                        } else {
                          log.d("Create account with $email and $password");
                          navigateTo(context, AuthName.route);
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
                          snackMessage(context, "Logging");
                          await Future.delayed(const Duration(seconds: 2));
                          log.d("successful");
                          password = passwordController.value.text;
                          email = emailController.value.text;
                          await ref
                              .read(authenticationStateProvider.notifier)
                              .signIn(email, password);
                          final isLogged = await ref
                              .read(authenticationStateProvider.notifier)
                              .isUserLogged();

                          if (isLogged) {
                            
                            log.d("islogged is true");
                            passwordController.clear();
                            emailController.clear();
                            navigateTo(context, AssistantsScreen.route);
                          } else {
                            snackMessage(context, "Not Logged");
                            log.d("islogged is false");
                          }

                          //success:
                          // navigateTo(context, AssistantsScreen.route);
                          //failed:
                          // nouser: navigateTo(context, AuthName.route);
                          return;
                        } else {
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
