import 'package:flutter/material.dart';
import '../../data/bloc/characterBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/model/character.dart';
import '../../ui/customWidgets/characterDialog.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final bool forFavourite;

  CharacterTile({@required this.character, @required this.forFavourite});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CharacterBloc>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(character.image),
      ),
      title: Text(character.name),
      trailing: forFavourite
          ? IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                bloc.removeFromFavourite(character.id);
              })
          : null,
      onTap: () {
        showDialog(
            barrierColor: Colors.black87,
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CharacterDialog(
                character: character,
              );
            });
      },
    );
  }
}
