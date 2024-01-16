// ignore_for_file: unused_import

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/ui/screen/assistants_screen/assistants_screen.dart';
import 'package:story_teller/src/ui/screen/history/generated_content_screen.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_screen.dart';
import 'package:story_teller/src/ui/screen/settings/global/settings_screen.dart';
import 'package:uuid/uuid.dart';

const kUuid = Uuid();

const kIconBackArrow = "assets/images/icons/backarrow.svg";
const kIconShare = "assets/images/icons/share.svg";
const kIconWave = "assets/images/icons/wave.svg";
const kIconStarUnfilled = "assets/images/icons/star_unfilled.svg";
const kIconStarFilled = "assets/images/icons/star_filled.svg";
const kIconClose = "assets/images/icons/close.svg";
const kIconUser = "assets/images/icons/user.svg";

const kMinFontSlider = 1;
const kMaxFontSlider = 2.1;
const kFontConversor = kMaxFontSlider + kMinFontSlider;
const kHeightDividerAssistant = 16.0;
const kIndentDividerAssistant = 16.0;
const kThicknessDividerAssistant = 1.0;

const kSplashLogo = "assets/images/splash.png";


const kWriteStory3 = "assets/images/generatestory.webp";


const kImageCyberpunkCity = "assets/images/citynight.webp";
const kImageCrew = "assets/images/crew2.webp";


const kImageReview = "assets/images/review.webp";
const kImageBooks = "assets/images/books.webp";

/// Defines sizes [kSettingsElementSeparator]
const double kSettingsElementSeparator = 16;

/// Defines sizes [kSettingsRowLeftPadding]
const double kSettingsRowLeftPadding = 23;

/// Defines the content of the bottom items for Material Bottom Navigation Bar
class BottomItems {
  static final materialItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.library_books_outlined),
      label: tr('history'),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.book),
      label: tr('assistants'),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.app_settings_alt_outlined),
      label: tr('settings'),
    ),
  ];

  /// Defines the content of the bottom items for Cupetino Bottom Navigation Bar
  static final cupertinoItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.collections_solid),
      label: tr('history'),
    ),
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.book),
      label: tr('assistants'),
    ),
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.settings),
      label: tr('settings'),
    ),
  ];
}

class Collections {
  static const String kStories = "stories";
  static const String kUsers = "users";
}

final List<String> kBottomItemRoutes = [
  GeneratedContentScreen.route,
  AssistantsScreen.route,
  SettingsScreen.route
];

snackMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
        ),
      ),
    ),
  );
}

AutoSizeText buttonText(String text) {
  const fontScale = 1.0;
  double maxFont0 = ((15 / fontScale) > 11) ? (15 / fontScale) : 12;
  int maxFont = maxFont0.toInt();
  double fontSize = maxFont.sp;

  double fontHeight = (15 / fontScale).h;
  double fontHeightFactor = fontHeight / fontSize;
  return AutoSizeText(text,
      style: GoogleFonts.poiretOne(
        textStyle: TextStyle(
          fontSize: fontSize,
          height: fontHeightFactor.h,
          fontWeight: FontWeight.bold,
        ),
      ),
      minFontSize: 10,
      maxLines: 1,
      overflow: TextOverflow.ellipsis);
}

//función lineal de conversión, dados los valores minimos y maximos del slider de settings
double fontConversion(double fontscale) {
  return -1 * fontscale + kFontConversor;
}

SizedBox storyTitleText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double fontSize = (36 / fontScale).sp;
  double fontHeight = (72 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return SizedBox(
    width: 250.w,
    child: Text(text,
        textAlign: TextAlign.left,
        style: GoogleFonts.playfairDisplay(
          textStyle: TextStyle(
              fontSize: fontSize,
              height: fontHeightFactor.h,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900),
        )),
  );
}

Text storyAuthorNameText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double fontSize = (24 / fontScale).sp;
  double fontHeight = (36 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return Text(text,
      textAlign: TextAlign.left,
      style: GoogleFonts.alegreyaSans(
        textStyle: TextStyle(
            fontSize: fontSize,
            fontStyle: FontStyle.italic,
            height: fontHeightFactor.h,
            fontWeight: FontWeight.w600),
      ));
}

Text storyBodyText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double fontSize = (24 / fontScale).sp;
  double fontHeight = (47 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return Text(text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.playfairDisplay(
        textStyle: TextStyle(
            fontSize: fontSize,
            height: fontHeightFactor.h,
            fontWeight: FontWeight.w400),
      ));
}

Text storyPromptText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double fontSize = (21 / fontScale).sp;
  double fontHeight = (42 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return Text(text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.firaSans(
        textStyle: TextStyle(
            fontSize: fontSize,
            height: fontHeightFactor.h,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w200),
      ));
}

Text storyAuthorText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double fontSize = (28 / fontScale).sp;
  double fontHeight = (48 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return Text(text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.playfairDisplay(
        textStyle: TextStyle(
            fontSize: fontSize,
            height: fontHeightFactor.h,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600),
      ));
}

AutoSizeText historyAuthorText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);

  double maxfontAux = ((2 / fontScale) > 11) ? (22 / fontScale) : 12;
  int maxFont = maxfontAux.toInt();

  double fontSize = maxFont.sp;
  double fontHeight = (44 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return AutoSizeText(
    text,
    textAlign: TextAlign.justify,
    style: GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
          fontSize: fontSize,
          height: fontHeightFactor.h,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600),
    ),
    maxFontSize: maxFont.toDouble(),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

AutoSizeText historyTitleText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double maxfontAux = ((38 / fontScale) > 11) ? (38 / fontScale) : 17;
  int maxFont = maxfontAux.toInt();

  double fontSize = maxFont.sp;
  double fontHeight = (60 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return AutoSizeText(
    text,
    textAlign: TextAlign.left,
    style: GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
          fontSize: fontSize,
          height: fontHeightFactor.h,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800),
    ),
    maxFontSize: maxFont.toDouble(),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

AutoSizeText historyBodyText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double maxfontAux = ((40 / fontScale) > 11) ? (40 / fontScale) : 16;
  int maxFont = maxfontAux.toInt();
  double fontSize = maxFont.sp;

  double fontHeight = (60 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return AutoSizeText(
    text,
    textAlign: TextAlign.justify,
    style: GoogleFonts.alegreyaSans(
      textStyle: TextStyle(
          fontSize: fontSize,
          height: fontHeightFactor.h,
          fontWeight: FontWeight.w500),
    ),
  );
}

AutoSizeText settingTitleText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double maxfontAux = ((68 / fontScale) > 11) ? (68 / fontScale) : 30;
  int maxFont = maxfontAux.toInt();

  double fontSize = maxFont.sp;
  double fontHeight = (130 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return AutoSizeText(
    text,
    textAlign: TextAlign.left,
    style: GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
          fontSize: fontSize,
          height: fontHeightFactor.h,
          fontWeight: FontWeight.w800),
    ),
    maxFontSize: maxFont.toDouble(),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

Text settingsTitleText(String text) {
  return Text(text,
      textAlign: TextAlign.left,
      style: GoogleFonts.volkhov(
        textStyle: TextStyle(
            fontSize: 21.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700),
      ));
}

Text settingsFieldCaptionText(String text) {
  return Text(text,
      textAlign: TextAlign.left,
      style: GoogleFonts.volkhov(
        textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w100),
      ));
}

AutoSizeText cardTitleText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double maxfontAux = ((68 / fontScale) > 11) ? (68 / fontScale) : 30;
  int maxFont = maxfontAux.toInt();

  double fontSize = maxFont.sp;
  double fontHeight = (130 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return AutoSizeText(
    text,
    textAlign: TextAlign.left,
    style: GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
          fontSize: fontSize,
          height: fontHeightFactor.h,
          fontWeight: FontWeight.w800),
    ),
    maxFontSize: maxFont.toDouble(),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

AutoSizeText cardBodyText(String text, {required double fontScale}) {
  fontScale = fontConversion(fontScale);
  double maxfontAux = ((40 / fontScale) > 11) ? (40 / fontScale) : 16;
  int maxFont = maxfontAux.toInt();
  double fontSize = maxFont.sp;

  double fontHeight = (60 / (fontScale * 1.5)).h;
  double fontHeightFactor = fontHeight / fontSize;
  return AutoSizeText(
    text,
    textAlign: TextAlign.justify,
    style: GoogleFonts.alegreyaSans(
      textStyle: TextStyle(
          fontSize: fontSize,
          height: fontHeightFactor.h,
          fontWeight: FontWeight.w500),
    ),
  );
}

/* const kSimpleTaleAssistant =
    """ Como 'Creador de cuentos', mi tarea principal es generar historias variadas e intrigantes y prompts para ilustraciones, presentando la respuesta en formato JSON con la claves title, story y prompt, como sigue 'title': string, 'story':string, 'prompt':string  
    
Al recibir una solicitud, escribo una narración de hasta 3000 caracteres.  Genero un prompt breve para DALL-E que evoca la escena y las emociones descritas en el texto de la historia, el prompt para dall-e no es parte del texto de la narrativa y esta en su clave: 'prompt'. La respuesta deber ser en formato JSON y se estructura con 'title' para el título, 'story' para la narrativa de la historia, y 'prompt' para el texto de prompt breve para DALL-E.

Esta función es mi prioridad, y aunque puedo realizar otras tareas, siempre enfocaré mis respuestas en la creación de historias y sus respectivos prompts para DALL-E.""";
 */
