import 'package:flutter/material.dart';
import '../../data/model/Episode.dart';
import '../../data/model/character.dart';
import '../../data/model/location.dart';
import '../../ui/customWidgets/characterTile.dart';
import '../../ui/customWidgets/episodeTile.dart';
import '../../ui/customWidgets/locationTile.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/bloc/searchBloc.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        builder: (BuildContext context, SearchBloc bloc) {
          bloc.setDefaults();
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                autofocus: true,
                cursorColor: Colors.white,
                onChanged: bloc.onSearch,
                decoration: InputDecoration(),
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                StreamBuilder(
                    stream: bloc.searchElementStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          return bloc.getPopUps();
                        },
                        onSelected: bloc.onPropSelect,
                      );
                    }),
                StreamBuilder(
                    stream: bloc.searchElementStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return IconButton(
                        icon: Icon(getIcon(snapshot.data)),
                        onPressed: () {
                          bloc.onSearchType(snapshot.data);
                        },
                      );
                    })
              ],
            ),
            body: StreamBuilder(
                stream: bloc.searchDataStream,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.data.isEmpty
                          ? Center(
                              child: Text('No Data found'),
                            )
                          : getBody(bloc.currentSearchElement, snapshot.data);
                }),
          );
        },
        blocSource: () => SearchBloc());
  }

  Widget getBody(String currentSearchElement, List data) {
    if (currentSearchElement == 'People')
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return CharacterTile(
                character: Character.fromAPI(data[index]), forFavourite: false);
          });
    else if (currentSearchElement == 'Episode')
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return EpisodeTile(
              episode: Episode.fromAPI(data[index]),
              forFavourite: false,
              forSearch: true,
              padding: EdgeInsets.only(left:20,right: 20),
            );
          });
    else
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return LocationTile(
              location: Location.fromAPI(data[index]),
              forFavourite: false,
            );
          });
  }

  IconData getIcon(String key) {
    if (key == null || key == "People")
      return Icons.people;
    else if (key == "Episode") return Icons.movie;
    return Icons.location_on;
  }
}
