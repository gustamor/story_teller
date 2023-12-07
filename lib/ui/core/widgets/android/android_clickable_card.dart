import 'package:flutter/material.dart';
import 'package:story_teller/domain/widgets/ai_clickable_card.dart';

class AndroidClickableCard extends StatelessWidget implements AiClickableCard {
  const AndroidClickableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
      ),
    );
  }
}
