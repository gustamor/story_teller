import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WidgetFactory {
  Widget createButton(
      {double? padding,
      Color? bgColor,
      Color? iosBackgroundColor,
      Color? androidBackgroundColor,
      double? iosPadding,
      double? androidPadding});

  Widget createClickableCard();
}
