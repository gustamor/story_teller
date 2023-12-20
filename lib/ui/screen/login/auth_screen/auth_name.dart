import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/ui/core/providers/theme_mode_provider_impl.dart';
import 'package:story_teller/ui/core/widgets/button.dart';
import 'package:story_teller/ui/core/widgets/text_form_field.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
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
  
    

    final themeModeState = ref.watch(themeModeProvider);


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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(child:
                    IconButton(
                        icon: Icon(
                          themeModeState == ThemeMode.light
                              ? Icons.dark_mode
                              : Icons.light_mode,
                        ),
                        onPressed: () => ref.read(themeModeProvider.notifier).switchTheme(
                            themeModeState == ThemeMode.light ? true : false)),

                    ),
                 const  Text(
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
                        hintText: "Nombre",
                        filled: true,
                        borderRadius: 30,
                        borderSide: 3,
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    NiceButton(
                      clickFunction: () =>
                          navigateTo(context, AssistantsScreen.route),
                      text: tr('enter_to_story_teller'),
                      textStyle: AndroidStyle.cardCaption,
                      height: 64,
                      width: 220,
                      padding: 16.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
