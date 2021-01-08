import 'package:flutter/material.dart';
import '../../data/model/character.dart';

class RecentCharacter extends StatelessWidget {
  final Character character;

  RecentCharacter({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(character.image),
        ),
        Text(character.name)
      ],
    );
  }
}
