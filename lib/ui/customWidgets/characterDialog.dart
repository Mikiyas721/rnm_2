import 'package:flutter/material.dart';
import '../../data/model/character.dart';

class CharacterDialog extends StatelessWidget {
  final Character character;

  CharacterDialog({@required this.character});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.network(
        character.image,
        width: MediaQuery.of(context).size.width * 0.9,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name :- ${character.name}'),
          Text('Gender :- ${character.gender}'),
          Text('Type :- ${character.type}'),
          Text('Species :- ${character.species}'),
          Text('Status :- ${character.status}'),
          Text('Created :- ${character.created}'),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'))
      ],
    );
  }
}
