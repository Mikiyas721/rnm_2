import 'package:flutter/material.dart';
import 'package:rnm/ui/customWidgets/characterCard.dart';
import '../../data/model/Episode.dart';

class EpisodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Episode episode = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(episode.episode),
      ),
      body: ListView(
        children: [
          Text('Full Information'),
          Card(
            child: Column(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Episode: '),
                  TextSpan(text: episode.episode)
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Name: '),
                  TextSpan(text: episode.name)
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Air Date: '),
                  TextSpan(text: episode.airDate)
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: 'Created: '),
                  TextSpan(text: episode.created)
                ])),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Characters'),
              Text('${episode.characters.length} Characters'),
            ],
          ),
          GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: episode.characters.length,
              itemBuilder: (BuildContext context, int index) {
                return CharacterCard(character: episode.characters[index]);
              })
        ],
      ),
    );
  }
}
