import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../ui/customWidgets/myPageView.dart';
import '../../data/model/Episode.dart';
import '../../data/model/character.dart';
import '../../data/bloc/characterBloc.dart';
import '../../data/bloc/episodeBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../ui/customWidgets/episodeTile.dart';
import '../../ui/customWidgets/recentCharacter.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 5),
          child: CupertinoTextField(
            placeholder: 'Search',
            readOnly: true,
            onTap: (){
              Navigator.pushNamed(context, '/searchPage');
            },
          ),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 20),
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.pushNamed(context, '/favouritePage');
              }),
          IconButton(
              padding: EdgeInsets.only(right: 20),
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.pushNamed(context, '/locationsPage');
              })
        ],
      ),
      body: BlocProvider(
          blocSource: () => CharacterBloc(),
          builder: (BuildContext context, CharacterBloc bloc) {
            bloc.loadCharacters();
            bloc.loadRecentCharacters();
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Characters',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: 280,
                    child: StreamBuilder(
                        stream: bloc.characterStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          return snapshot.data == null
                              ? Center(child: CircularProgressIndicator())
                              : MyPageView(data: snapshot.data);
                        }),
                  ),
                  Text(
                    'Recently Viewed',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: 120,
                    child: StreamBuilder(
                        stream: bloc.recentCharacterStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          return snapshot.data == null
                              ? Center(child: CircularProgressIndicator())
                              : snapshot.data.isEmpty
                                  ? Center(
                                      child: Text('No data'),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return RecentCharacter(
                                                character: Character.fromDB(
                                                    snapshot.data[index]));
                                          }),
                                    );
                        }),
                  ),
                  Text(
                    'Episodes',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  BlocProvider(
                    blocSource: () => EpisodeBloc(),
                    builder: (BuildContext context, EpisodeBloc bloc) {
                      bloc.loadEpisodes();
                      return StreamBuilder(
                          stream: bloc.episodesStream,
                          builder: (context, snapshot) {
                            return snapshot.data == null
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return EpisodeTile(
                                        episode: Episode.fromAPI(
                                            snapshot.data[index]['data']),
                                        forFavourite: false,
                                        isActive: snapshot.data[index]
                                        ['isStarred'],
                                      );
                                    });
                          });
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}
