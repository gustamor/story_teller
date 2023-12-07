import 'package:flutter/material.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceClickableCard extends StatelessWidget {
  NiceClickableCard({super.key});

  final ui = uiFactory();

  @override
  Widget build(BuildContext context) {
    return ui.createClickableCard();
  }
}
