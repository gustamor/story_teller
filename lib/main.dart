// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/data/providers/auth_providers.dart';
import 'package:story_teller/data/services/riverpod_logger_impl.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/services/tell_logger.dart';
import 'package:story_teller/firebase_options.dart';
import 'package:story_teller/ui/core/providers/theme_mode_provider_impl.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/feedback/rate_us_screen.dart';
import 'package:story_teller/ui/screen/history/generated_content_screen.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_check_if_verified.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_forgotten_password.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_name.dart';
import 'package:story_teller/ui/screen/login/auth_screens/auth_screen.dart';
import 'package:story_teller/ui/screen/settings/settings_screen.dart';
import 'package:story_teller/ui/screen/tale_generator/tale.dart';
import 'package:story_teller/ui/screen/tale_generator/tale_generator.dart';

void initIsarDB() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [],
    directory: dir.path,
  );
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  initIsarDB();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();
  await EasyLocalization.ensureInitialized();

  //setupSingletons();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('es'),
      ],
      path: 'assets/l10n',
      fallbackLocale: const Locale('es'),
      child: ProviderScope(
        observers: [
          LoggerRiverpod(),
        ],
        child: AiApp(),
      ),
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

/// Implements a [TellLogger] instance
final TellLogger log = LogImpl();

class AiApp extends ConsumerWidget {
  late String initialRoute;

  AiApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  setDeviceOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  authChecker(WidgetRef ref) {
    final logged = ref.watch(authStateChangesProvider);
    logged.when(
      data: (user) {
        if (user != null && user.emailVerified) {
          initialRoute = AssistantsScreen.route;
          log.d(
            "user is logged",
          );
        } else {
          initialRoute = AuthScreen.route;
          log.d(
            "user is not logged",
          );
        }
      },
      error: (_, __) => log.d(
        "auth error",
      ),
      loading: () => log.d(
        "loading",
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const FlexScheme usedScheme = FlexScheme.redWine;
    final currentMode = ref.watch(themeModeProvider);

    authChecker(ref);
    setDeviceOrientation();

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
                initialRoute: initialRoute,
                routes: {
                  AuthScreen.route: (context) => AuthScreen(),
                  AuthName.route: (context) => const AuthName(),
                  AssistantsScreen.route: (context) => const AssistantsScreen(),
                  RateUsScreen.route: (context) => const RateUsScreen(),
                  TaleScreen.route: (context) => const TaleScreen(),
                  TaleGeneratorScreen.route: (context) =>
                      const TaleGeneratorScreen(),
                  GeneratedContentScreen.route: (context) =>
                      GeneratedContentScreen(),
                  SettingsScreen.route: (context) => const SettingsScreen(),
                  CheckIfUserIsVerified.route: (context) =>
                      const CheckIfUserIsVerified(),
                  PasswordForgottenScreen.route: (context) =>
                      PasswordForgottenScreen(),
                }),
          );
        });
  }
}
