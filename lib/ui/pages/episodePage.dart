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
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Card(
              color: Colors.black38,
              margin: EdgeInsets.only(top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Information',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                          TextSpan(text: '\nEpisode: '),
                          TextSpan(text: episode.episode)
                        ])),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                          TextSpan(text: 'Name: '),
                          TextSpan(text: episode.name)
                        ])),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                          TextSpan(text: 'Air Date: '),
                          TextSpan(text: episode.airDate)
                        ])),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                          TextSpan(text: 'Created: '),
                          TextSpan(text: episode.created)
                        ])),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Characters',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                Text(
                  '${episode.characters.length} Characters',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: episode.characters.length,
                itemBuilder: (BuildContext context, int index) {
                  return CharacterCard(character: episode.characters[index]);
                })
          ],
        ),
      ),
    );
  }
}
