import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/model/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isActive;

  CharacterCard({@required this.character, this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/characterPage', arguments: character);
        },
        child: isActive == null
            ? Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(character.image),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              )
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(character.image),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  Text(
                    character.name,
                    style:
                        TextStyle(color: isActive ? Colors.white : Colors.grey),
                  )
                ],
              ),
      ),
    );
  }
}
