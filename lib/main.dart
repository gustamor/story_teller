import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/data/providers/logger_riverpod.dart';
import 'package:story_teller/firebase_options.dart';
import 'package:story_teller/ui/core/providers/theme_mode_provider_impl.dart';
import 'package:story_teller/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/ui/screen/feedback/rate_us_screen.dart';
import 'package:story_teller/ui/screen/history/generated_content_screen.dart';
import 'package:story_teller/ui/screen/login/auth_screen/auth_name.dart';
import 'package:story_teller/ui/screen/login/auth_screen/auth_screen.dart';
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
        child: const AiApp(),
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

class AiApp extends ConsumerWidget {
  const AiApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const FlexScheme usedScheme = FlexScheme.redWine;
    final currentMode = ref.watch(themeModeProvider);

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
                initialRoute: AuthScreen.route,
                routes: {
                  AuthScreen.route: (context) => AuthScreen(),
                  AuthName.route: (context) => const AuthName(),
                  AssistantsScreen.route: (context) => AssistantsScreen(),
                  RateUsScreen.route: (context) => const RateUsScreen(),
                  TaleScreen.route: (context) => const TaleScreen(),
                  TaleGeneratorScreen.route: (context) =>
                      const TaleGeneratorScreen(),
                  GeneratedContentScreen.route: (context) =>
                      GeneratedContentScreen(),
                  SettingsScreen.route: (context) => const SettingsScreen(),
                }),
          );
        });
  }
}
