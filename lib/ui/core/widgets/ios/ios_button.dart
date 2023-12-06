import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_teller/domain/factories/nice_button.dart';

class IosButton extends StatelessWidget implements NiceButton {
  final double? padding;
  final Color? bgColor;
  final int? a;
  final int? b;

  const IosButton({super.key, this.padding, this.bgColor, this.a, this.b});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: CupertinoButton(
        color: bgColor ?? Colors.blue,
        child: const Text("Cupertino Button"),
        onPressed: () => {},
      ),
    );
  }
}
