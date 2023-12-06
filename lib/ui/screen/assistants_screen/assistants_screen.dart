import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class AssistantsScreen extends StatelessWidget {
  AssistantsScreen({super.key});

  static const String tag = "/assistants";
  final ui = uiFactory();

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.greenAccent,
              child: Text(
                "Me cago en tu loro",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
            ui.createButton(padding: 8.0, bgColor: Colors.deepPurple),
            ui.createClickableCard(),
          ],
        ),
      ),
    ));
  }
}
