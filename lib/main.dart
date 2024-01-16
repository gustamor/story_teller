// ignore_for_file: unused_local_variable, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/src/core/params.dart';
import 'package:story_teller/src/data/di/remote_config_service_provider.dart';

import 'package:story_teller/src/domain/models/dalle_model.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/data/services/riverpod_logger_impl.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/firebase_options.dart';
import 'package:story_teller/src/ui/core/providers/font_scale_provider.dart';
import 'package:story_teller/src/ui/core/providers/theme_mode_provider.dart';
import 'package:story_teller/src/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/src/ui/screen/feedback/rate_us_screen.dart';
import 'package:story_teller/src/ui/screen/history/generated_content_screen.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_check_if_verified.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_forgotten_password.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_name.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_screen.dart';
import 'package:story_teller/src/ui/screen/settings/global/settings_screen.dart';
import 'package:story_teller/src/ui/screen/settings/user/user_settings_main.dart';
import 'package:story_teller/src/ui/screen/settings/user/user_settings_profile.dart';
import 'package:story_teller/src/ui/screen/tale_generator/tale_from_history.dart';
import 'package:story_teller/src/ui/screen/tale_generator/tale_on_generated.dart';
import 'package:story_teller/src/ui/screen/tale_generator/tale_generator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  configureDio();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /* FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
 */
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  await dotenv.load(fileName: ".env");

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
        Locale('en'),
        Locale('de'),
        Locale('jp'),
        Locale('fr'),
        Locale('it'),
        Locale('pt'),
        Locale('ca'),
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

void configureDio() {
  // Set default configs
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 20);
  dio.options.receiveTimeout = const Duration(seconds: 20);
}

initRemoteConfig(WidgetRef ref) async {
  try {
    final remoteConfig = await ref.watch(remoteConfigProvider.future);
    Params.gptModel = await remoteConfig.getStringValue("gtp_model");
    Params.gptPrompt = await remoteConfig.getStringValue("gtp_prompt");
    final dalleRemote = await remoteConfig.getStringValue("dalle");
    Params.dalleModel = DalleModel.fromMap(
      json.decode(
        dalleRemote,
      ),
    );
    // ignore: empty_cdalleModelatches
  } catch (e) {
    throw Exception(e);
  }
}

/// Implements a [TellLogger] instance
final TellLogger log = LogImpl();

// ignore: must_be_immutable
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
    initRemoteConfig(ref);
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
              TaleOnGeneratedScreen.route: (context) =>
                  const TaleOnGeneratedScreen(),
              TaleGeneratorScreen.route: (context) =>
                  const TaleGeneratorScreen(),
              GeneratedContentScreen.route: (context) =>
                  GeneratedContentScreen(),
              SettingsScreen.route: (context) => const SettingsScreen(),
              CheckIfUserIsVerified.route: (context) =>
                  const CheckIfUserIsVerified(),
              PasswordForgottenScreen.route: (context) =>
                  PasswordForgottenScreen(),
              UserSettingsMainScreen.route: (context) =>
                  const UserSettingsMainScreen(),
              UserSettingsProfileScreen.route: (context) =>
                  const UserSettingsProfileScreen(),
              TaleFromHistoryScreen.route: (context) =>
                  const TaleFromHistoryScreen(),
            },
          ),
        );
      },
    );
  }
}
