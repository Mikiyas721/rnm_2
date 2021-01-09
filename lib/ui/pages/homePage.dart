import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/model/Episode.dart';
import '../../data/model/character.dart';
import '../../data/bloc/characterBloc.dart';
import '../../data/bloc/episodeBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../ui/customWidgets/episodeTile.dart';
import '../../ui/customWidgets/recentCharacter.dart';
import '../../ui/customWidgets/characterCard.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage;

  @override
  void initState() {
    selectedPage = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 5),
          child: CupertinoTextField(
            placeholder: 'Search',
          ),
        ),
        actions: [
          IconButton(padding: EdgeInsets.only(right: 20),
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
                              : PageView.builder(
                                  itemCount: snapshot.data.length,
                                  controller:
                                      PageController(viewportFraction: 0.5,initialPage: 2),
                                  onPageChanged: (int index) {
                                    setState(() {
                                      selectedPage = index;
                                    });
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Transform.scale(
                                        scale: index == selectedPage ? 1.05 : 1,
                                        child: CharacterCard(
                                            isActive: index == selectedPage
                                                ? true
                                                : false,
                                            character: Character.fromJson(
                                                snapshot.data[index])));
                                  },
                                );
                        }),
                  ),
                  Text(
                    'Recently Viewed',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: 150,
                    child: StreamBuilder(
                        stream: bloc.recentCharacterStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          return snapshot.data == null
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return RecentCharacter(
                                        character: snapshot.data[index]);
                                  });
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
                                        episode: Episode.fromJson(snapshot.data[index]),
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
