import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/ui/core/widgets/app_bar/navigation_app_bar.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';

class TaleScreen extends StatelessWidget {
  const TaleScreen({super.key});

  static const route = "/tale";

  void navigateTo(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          color: Colors.blue,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NiceAppBar(
                leftIcon: kIconBackArrow,
                title: "Asistentes",
                leftTapFunction: () =>
                    navigateTo(context, AssistantsScreen.route),
              ),
              SizedBox(
                height: 128.h,
              ),
               SingleChildScrollView(
                 physics: const ScrollPhysics(),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                    Container(
                      width: 500,
                      height: 280,
                      alignment: Alignment.center,
                      child: Image.network(
                        'https://i.postimg.cc/d3QMcjFp/gustavomore-a-futuristic-city-skyline-solar-punk-city-an-exte-37b9a7c2-f4ab-4a04-8d9b-c102a9ae1e66-3.png',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return const LinearProgressIndicator();
                          // You can use LinearProgressIndicator or CircularProgressIndicator instead
                        },
                        errorBuilder: (context, error, stackTrace) =>
                        const Text('Some errors occurred!'),
                      ),
                    ),
                  ],
                               ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
