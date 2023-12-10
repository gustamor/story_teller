import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/ui/core/widgets/button/button.dart';
import 'package:story_teller/ui/core/widgets/text_form_field/text_form_field.dart';
import 'package:story_teller/ui/themes/styles/text_styles.dart';

class AuthName extends StatelessWidget {
  const AuthName({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return SafeArea(
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0).r,
              child: const Icon(
                CupertinoIcons.clear,
              ),
            ),
            SizedBox(
              height: 128.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dinos el nombre por el que quieres te llamemos"),
                SizedBox(height: 16.w,),
                Padding(
                  padding:  EdgeInsets.symmetric(
                   horizontal: 48.w,
                  ),
                  child: NiceTextFormField(
                    hintText: "Nombre",
                    filled: true,
                    borderRadius: 30,
                    borderSide: 3,
                  ),
                ),
                SizedBox(height: 32.h,),
                NiceButton(
                  text: "Entrar a Story Teller",
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
    );
  }
}
