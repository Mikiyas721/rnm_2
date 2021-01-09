import 'package:flutter/material.dart';
import '../../data/model/Episode.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;

  EpisodeTile({@required this.episode});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, '/episodePage',arguments: episode);
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
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: Colors.yellow.shade500,
          size: 30,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/episodePage', arguments: episode);
        },
      ),
    );
  }
}
