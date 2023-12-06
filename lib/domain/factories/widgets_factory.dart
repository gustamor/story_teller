import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WidgetFactory {
  Widget createButton({double? padding, Color? bgColor, int? a, int? b});
  Widget createClickableCard();
}