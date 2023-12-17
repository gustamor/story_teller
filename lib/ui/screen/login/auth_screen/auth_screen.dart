import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:story_teller/data/services/firebase_service_impl.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/ui/core/widgets/button.dart';
import 'package:story_teller/ui/core/widgets/text_form_field.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/login/auth_screen/auth_name.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  static const route = "/auth_screen";

  final firebaseService = Provider<FirebaseServiceImpl>(
    (ref) => FirebaseServiceImpl(),
  );

  final log = LogImpl();

  void navigateTo(BuildContext context, String route) async {
    Navigator.pushNamed(context, route);
  }

  login(FirebaseServiceImpl auth) async {
    try {
      final userId =
          await auth.signIn("pepito@kakita.com", "12345678");

      log.i(userId);
        } catch (e) {}
  }

  signup(FirebaseServiceImpl auth) async {
    try {
      final userId =
          await auth.signUp("gustavo.sdasdasdasasda@gmail.com", "12345678");
      log.i("user created $userId");

        } catch (e) {
      log.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Material(
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
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
                    clickFunction: () => navigateTo(context, AuthName.route),
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
                    clickFunction: () =>
                        navigateTo(context, AssistantsScreen.route),
                    text: "Log in",
                    textStyle: AndroidStyle.cardCaption,
                    height: 64,
                    width: 220,
                    padding: 8.0,
                  ), //Login
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
