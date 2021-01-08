import 'package:flutter/material.dart';
import 'package:rnm/data/model/Episode.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  EpisodeCard({@required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(episode.episode),
              Spacer(),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(episode.characters[0].image),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage:
                      NetworkImage(episode.characters[1].image),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                     child: Text('+ ${episode.characters.length-2}'),
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(),
          RichText(
              text: TextSpan(children: [
                TextSpan(text: 'Name: '),
                TextSpan(text: episode.name)
              ])),
          RichText(
              text: TextSpan(children: [
                TextSpan(text: 'Created: '),
                TextSpan(text: episode.created)
              ])),
          RichText(
              text: TextSpan(children: [
                TextSpan(text: 'Air Date: '),
                TextSpan(text: episode.airDate)
              ])),
        ],
      ),
    );
  }
}
