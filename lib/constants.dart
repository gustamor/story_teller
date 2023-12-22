import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kIconBackArrow = "assets/images/icons/backarrow.svg";
const kIconShare = "assets/images/icons/share.svg";
const kIconWave = "assets/images/icons/wave.svg";
const kIconStarUnfilled = "assets/images/icons/star_unfilled.svg";
const kIconStarFilled = "assets/images/icons/star_filled.svg";
const kIconClose = "assets/images/icons/close.svg";

const kImageCyberpunkCity =
    "https://i.postimg.cc/d3QMcjFp/gustavomore-a-futuristic-city-skyline-solar-punk-city-an-exte-37b9a7c2-f4ab-4a04-8d9b-c102a9ae1e66-3.png";
const kImagePlanet =
    "https://i.postimg.cc/RVZK6xhn/gustavomore-httpss-mj-runa-UKbn81m-Ipo-httpss-mj-run-EAIfn64a-Lm8-209683bf-662b-49e3-b12f-e46de98790a7-3.png";
const kImageBookPage =
    "https://i.postimg.cc/Bv2mxG0k/gustavomore-picture-in-blacklines-no-colors-white-backgroun-1ca69053-7105-4eef-880b-0bcf6e6a7d24-2.png";
const kImageFace =
    "https://i.postimg.cc/Dy0G84LM/gustavomore-extremely-detailed-close-up-documentary-photograp-194f4935-1958-4588-80ad-2074a57102fb-1.png";

/// Defines sizes [kSettingsElementSeparator]
const double kSettingsElementSeparator = 16;

/// Defines sizes [kSettingsRowLeftPadding]
const double kSettingsRowLeftPadding = 23;

/// Defines the content of the bottom items for Material Bottom Navigation Bar
class BottomItems {
  static final materialItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.star),
      label: tr("history"),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.book),
      label: tr('assitants'),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings),
      label: tr('settings'),
    ),
  ];

  /// Defines the content of the bottom items for Cupetino Bottom Navigation Bar
  static final cupertinoItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.star_fill),
      label: tr('history'),
    ),
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.book),
      label: tr('assitants'),
    ),
    BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.settings),
      label: tr('settings'),
    ),
  ];
}

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
