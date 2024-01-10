import 'package:flutter/cupertino.dart';

class AndroidStyle {
  static const TextStyle cardCaption =
    TextStyle(
      fontFamily: 'playfairDisplay',
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );
  static const TextStyle cardDescription =
    TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
}

class IosStyle {
  static const TextStyle cardCaption = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle cardDescription =  TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}
