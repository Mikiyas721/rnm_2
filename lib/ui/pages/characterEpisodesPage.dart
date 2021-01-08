import 'package:flutter/material.dart';
import 'package:rnm/ui/customWidgets/episodeCard.dart';
import '../../data/model/character.dart';

class CharacterEpisodesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(backgroundImage: NetworkImage(character.image)),
        title: Text(character.name),
        actions: [Text('${character.episode.length} Episodes')],
      ),
      body: ListView.builder(
          itemCount: character.episode.length,
          itemBuilder: (BuildContext context, int index) {
            return EpisodeCard(
              episode: character.episode[index],
            );
          }),
    );
  }
}
