import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    selectedPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: CupertinoTextField(
          placeholder: 'Search',
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.pushNamed(context, '/locationsPage');
              })
        ],
      ),
      body: BlocProvider(
          blocSource: () => CharacterBloc(),
          builder: (BuildContext context, CharacterBloc bloc) {
            return ListView(
              children: [
                Text(
                  'Characters',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                StreamBuilder(
                    stream: bloc.characterStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      return PageView.builder(
                        itemCount: snapshot.data.length,
                        controller: PageController(viewportFraction: 0.3),
                        onPageChanged: (int index) {
                          setState(() {
                            selectedPage = index;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Transform.scale(
                              scale: index == selectedPage ? 1.2 : 1,
                              child: CharacterCard(
                                  isActive:
                                      index == selectedPage ? true : false,
                                  character: snapshot.data[index]));
                        },
                      );
                    }),
                Text(
                  'Recently Viewed',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                StreamBuilder(
                    stream: bloc.recentCharacterStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RecentCharacter(
                                character: snapshot.data[index]);
                          });
                    }),
                Text(
                  'Episodes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                BlocProvider(
                  blocSource: () => EpisodeBloc(),
                  builder: (BuildContext context, EpisodeBloc bloc) {
                    return StreamBuilder(
                        stream: null,
                        builder: (context, snapshot) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return EpisodeTile(
                                  episode: snapshot.data[index],
                                );
                              });
                        });
                  },
                )
              ],
            );
          }),
    );
  }
}
