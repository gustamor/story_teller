import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_teller/data/services/firebase_service_impl.dart';
import 'package:story_teller/firebase_options.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/login/auth_screen/auth_name.dart';
import 'package:story_teller/ui/screen/login/auth_screen/auth_screen.dart';
import 'package:story_teller/ui/screen/tale_generator/tale.dart';

import 'data/providers/themes_provicer_impl.dart';
GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<FirebaseServiceImpl>(() => FirebaseServiceImpl());
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();
  await EasyLocalization.ensureInitialized();

  setupSingletons();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('es'),
      ],
      path: 'assets/l10n',
      fallbackLocale: const Locale('es'),
      child: const ProviderScope (child:  AiApp(),),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AiApp extends ConsumerWidget {
  const AiApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const FlexScheme usedScheme = FlexScheme.redWine;
    final currentMode = ref.watch(themesProvider);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode cm, __) {
          return ScreenUtilInit(
            minTextAdapt: true,
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'AI Story Teller',
                theme: FlexThemeData.light(
                  scheme: usedScheme,
                  appBarElevation: 0.5,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
                darkTheme: FlexThemeData.dark(
                  scheme: usedScheme,
                  appBarElevation: 2,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
                themeMode: currentMode,
                initialRoute: TaleScreen.route,
                routes: {
                  AuthScreen.route: (context) =>  AuthScreen(),
                  AuthName.route: (context) => const AuthName(),
                  AssistantsScreen.route: (context) => AssistantsScreen(),
                  TaleScreen.route: (context) => const TaleScreen(),

                }),
          );
        });
  }
}
