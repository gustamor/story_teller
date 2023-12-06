import 'package:flutter/material.dart';
import 'package:story_teller/domain/factories/nice_button.dart';

class AndroidButton extends StatelessWidget implements NiceButton {
  final double? padding;
  final Color? color;

  const AndroidButton({super.key, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color!, // background color
          foregroundColor: Colors.white, // text color
        ),
        onPressed: () => {},
        child: const Text("Material Button"),
      ),
    );
  }
}
