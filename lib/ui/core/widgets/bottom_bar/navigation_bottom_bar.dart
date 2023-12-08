import 'package:flutter/widgets.dart';
import 'package:story_teller/ui/core/factories/ui_factory.dart';

class NiceBottomBar extends StatelessWidget {
   NiceBottomBar({super.key});

  final ui = uiFactory();
  @override
  Widget build(BuildContext context) {
    return ui.navigationBottomBar();
  }
}
