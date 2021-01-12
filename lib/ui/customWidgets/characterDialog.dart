import 'package:flutter/material.dart';
import '../../ui/customWidgets/myText.dart';
import '../../data/model/character.dart';

class CharacterDialog extends StatelessWidget {
  final Character character;

  CharacterDialog({@required this.character});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.black.withOpacity(0),
      title: Image.network(
        character.image,
        width: MediaQuery.of(context).size.width * 0.9,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(label: 'Name', value: '${character.name}',padding: EdgeInsets.all(0),textColor: Colors.white,),
          MyText(label: 'Gender', value: '${character.gender}',padding: EdgeInsets.all(0),textColor: Colors.white,),
          MyText(label: 'Type', value: '${character.type}',padding: EdgeInsets.all(0),textColor: Colors.white,),
          MyText(label: 'Species', value: '${character.species}',padding: EdgeInsets.all(0),textColor: Colors.white,),
          MyText(label: 'Status', value: '${character.status}',padding: EdgeInsets.all(0),textColor: Colors.white,),
          MyText(label: 'Created', value: '${character.created}',padding: EdgeInsets.all(0),textColor: Colors.white,),

        ],
      ),
      actions: [
        RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Colors.blueAccent.shade400,
            child: Text('Close',style: TextStyle(color: Colors.white),))
      ],
    );
  }
}
