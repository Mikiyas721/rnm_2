import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/model/Episode.dart';
import '../../ui/customWidgets/myText.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  EpisodeCard({@required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.black38, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                episode.episode,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              Container(
                width: 80,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(episode
                            .characters[
                                Random().nextInt(episode.characters.length - 1)]
                            .image),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(episode
                            .characters[
                                Random().nextInt(episode.characters.length - 1)]
                            .image),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(backgroundColor: Colors.black45,
                        child: Text('+ ${episode.characters.length - 2}'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(),
          MyText(
              label: 'Name', value: episode.name, padding: EdgeInsets.all(0)),
          MyText(
              label: 'Created',
              value: episode.created,
              padding: EdgeInsets.all(0)),
          MyText(
              label: 'Air Date',
              value: episode.airDate,
              padding: EdgeInsets.all(0)),
        ],
      ),
    );
  }
}
