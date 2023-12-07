import 'package:flutter/material.dart';

class AndroidAiButton extends StatelessWidget {
  final double? padding;
  final Color? androidBackgroundColor;
  final double? androidPadding;
  final Color? backgroundColor;
  final Color? iosBackgroundColor;
  final double? iosPadding;

  const AndroidAiButton({
    super.key,
    this.padding,
    this.androidBackgroundColor,
    this.androidPadding,
    this.backgroundColor,
    this.iosBackgroundColor,
    this.iosPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: androidBackgroundColor ?? backgroundColor,
          // background color
          foregroundColor: Colors.white, // text color
        ),
        onPressed: () => {},
        child: const Text("Material Button"),
      ),
    );
  }
}
