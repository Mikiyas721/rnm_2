import 'package:flutter/material.dart';
import '../../data/model/character.dart';

class RecentCharacter extends StatelessWidget {
  final Character character;

  RecentCharacter({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Expanded(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(character.image),
              radius: 40,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                character.name,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
