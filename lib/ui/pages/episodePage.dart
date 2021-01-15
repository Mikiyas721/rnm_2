import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../ui/customWidgets/characterCard.dart';
import '../../ui/customWidgets/myText.dart';
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
                        )),
                    MyText(
                        label: '\nEpisode',
                        value: episode.episode,
                        padding: EdgeInsets.all(0)),
                    MyText(
                        label: 'Name',
                        value: episode.name,
                        padding: EdgeInsets.all(0)),
                    MyText(
                        label: 'Air Date',
                        value: episode.airDate,
                        padding: EdgeInsets.all(0)),
                    MyText(
                        label: 'Created',
                        value: DateFormat('dd-mm-yyyy')
                            .format(DateTime.parse(
                            episode.created)),
                        padding: EdgeInsets.all(0)),
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
