import 'package:flutter/material.dart';
import '../../ui/customWidgets/episodeCard.dart';
import '../../data/model/character.dart';

class CharacterEpisodesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(backgroundImage: NetworkImage(character.image)),
        ),
        title: Text(character.name),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 20, right: 20),
            child: Text('${character.episode.length} Episodes'),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
            itemCount: character.episode.length,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        EpisodeCard(
                          episode: character.episode[index],
                        )
                      ],
                    )
                  : EpisodeCard(
                      episode: character.episode[index],
                    );
            }),
      ),
    );
  }
}
