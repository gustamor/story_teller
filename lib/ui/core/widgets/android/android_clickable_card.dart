import 'package:flutter/material.dart';
import 'package:story_teller/domain/factories/nice_clickable_card.dart';

class AndroidClickableCard extends StatelessWidget
    implements NiceClickableCard {
  const AndroidClickableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.white,
        ),
      ),
    );
  }
}
