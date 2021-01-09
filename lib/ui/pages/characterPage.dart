import 'package:flutter/material.dart';
import 'package:rnm/ui/customWidgets/myText.dart';
import '../../data/model/character.dart';

class CharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(character.image))),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 50,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
          Positioned(
              child: DraggableScrollableSheet(
                  maxChildSize: 0.6,
                  minChildSize: 0.4,
                  initialChildSize: 0.4,
                  builder: (BuildContext context, ScrollController controller) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Card(
                              margin: EdgeInsets.only(right: 30, bottom: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: IconButton(
                                icon: Icon(Icons.favorite),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 40),
                                controller: controller,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        character.name,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 30,
                                          ),
                                          Text(character.location.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 30, bottom: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${character.episode.length} episodes',
                                                style: TextStyle(fontSize: 16)),
                                            RaisedButton(
                                              padding: EdgeInsets.all(12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                child: Text(
                                                  'View',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue.shade500,
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      '/characterEpisodesPage',
                                                      arguments: character);
                                                })
                                          ],
                                        ),
                                      ),
                                      Text('Full Information',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      MyText(label: 'Name', value: character.name),
                                      MyText(label: 'Gender', value: character.gender),
                                      MyText(label: 'Species', value: character.species),
                                      MyText(label: 'Origin', value: character.origin.name),
                                      MyText(label: 'Location', value: character.location.name),
                                      MyText(label: 'Episodes', value: character.episode.length.toString()),
                                      MyText(label: 'Type', value: character.type),
                                      MyText(label: 'Status', value: character.status),
                                      MyText(label: 'Created', value: character.created),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
