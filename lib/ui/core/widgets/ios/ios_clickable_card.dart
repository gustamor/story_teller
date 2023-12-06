
import 'package:flutter/cupertino.dart';
import 'package:story_teller/domain/factories/nice_clickable_card.dart';

class IosClickableCard extends StatelessWidget implements NiceClickableCard {
  const IosClickableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/splash_logo.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: const Text(
            "Mindfulness",
            style: TextStyle(
                color: Color(0xfffcfcfc), fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Card is clicked.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('ok'),
                onPressed: () {
                  Navigator.pop(context, 'ok');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
