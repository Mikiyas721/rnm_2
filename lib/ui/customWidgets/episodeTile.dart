import 'package:flutter/material.dart';
import '../../data/model/Episode.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;

  EpisodeTile({@required this.episode});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Icon(Icons.movie),
      ),
      title: Text(episode.episode),
      subtitle: Text(episode.name),
      trailing: IconButton(
        icon: Icon(Icons.star,color: Colors.yellow.shade500,),
        onPressed: () {
          Navigator.pushNamed(context, '/episodePage',arguments: episode);
        },
      ),
    );
  }
}
