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
                height: 270,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(character.image),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              )
            : Column(
                children: [
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(bottom: 10,right: 5,top: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(character.image),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  Text(
                    character.name,
                    style:
                        TextStyle(color: isActive ? Colors.black : Colors.grey),
                  )
                ],
              ),
      ),
    );
  }
}
