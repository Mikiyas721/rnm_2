import 'package:flutter/material.dart';
import '../../data/model/character.dart';

class CharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(character.image))),
            child: Container(
              color: Colors.grey,
              child: IconButton(
                  icon: Icon(Icons.arrow_back_sharp),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
          Positioned(
              child: DraggableScrollableSheet(
                  maxChildSize: 0.8,
                  minChildSize: 0.5,
                  initialChildSize: 0.5,
                  builder: (BuildContext context, ScrollController controller) {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Icon(Icons.favorite),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: ListView(
                              controller: controller,
                              children: [
                                Text(character.name),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    Text(character.origin.name)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        '${character.episode.length} episodes'),
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Text('View'),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/characterEpisodesPage',
                                              arguments: character);
                                        })
                                  ],
                                ),
                                Text('Full Information'),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Name'),
                                  TextSpan(text: character.name)
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Origin'),
                                  TextSpan(text: character.origin.name)
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Gender'),
                                  TextSpan(text: character.gender)
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Species'),
                                  TextSpan(text: character.species)
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Episodes'),
                                  TextSpan(
                                      text: character.episode.length.toString())
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Type'),
                                  TextSpan(text: character.type)
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Location'),
                                  TextSpan(text: character.location.name)
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Status'),
                                  TextSpan(text: character.status)
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Created'),
                                  TextSpan(text: character.created)
                                ]))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}
