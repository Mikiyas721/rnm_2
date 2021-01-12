import 'package:flutter/material.dart';
import '../../data/bloc/episodeBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/model/Episode.dart';
import '../../ui/customWidgets/favouriteIcon.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;
  final bool forFavourite;
  final bool isActive;

  EpisodeTile(
      {@required this.episode,
      @required this.forFavourite,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    EpisodeBloc bloc = Provider.of<EpisodeBloc>(context);
    return ListTile(
        onTap: episode.characters == null
            ? null
            : () {
                Navigator.pushNamed(context, '/episodePage',
                    arguments: episode);
              },
        contentPadding: EdgeInsets.all(0),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black38),
          child: Icon(
            Icons.movie,
            color: Colors.white,
          ),
        ),
        title: Text(episode.episode),
        subtitle: Text(episode.name),
        trailing: forFavourite
            ? IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  bloc.removeFromFavourite(episode.id);
                })
            : TwoStateIconButton(
                inActiveIcon: Icon(
                  Icons.star_border,
                  color: Colors.grey.shade500,
                  size: 30,
                ),
                onTap: (bool isActive) async {
                  await bloc.onStarTap(isActive, episode);
                },
                isActive: isActive,
                activeIcon: Icon(
                  Icons.star,
                  color: Colors.yellow.shade500,
                  size: 30,
                ),
              ));
  }
}
