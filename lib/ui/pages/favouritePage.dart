import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../data/bloc/characterBloc.dart';
import '../../data/bloc/episodeBloc.dart';
import '../../data/bloc/locationBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../data/model/Episode.dart';
import '../../data/model/character.dart';
import '../../data/model/location.dart';
import '../../ui/customWidgets/characterTile.dart';
import '../../ui/customWidgets/episodeTile.dart';
import '../../ui/customWidgets/locationTile.dart';

class FavouritePage extends StatelessWidget {
  final List<String> images = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
    'assets/9.jpg',
    'assets/10.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: CarouselSlider(
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.4,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5)),
                    items: images
                        .map((String url) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(url),
                                      fit: BoxFit.cover)),
                            ))
                        .toList(),
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Icons.people,
                    Icons.movie,
                    Icons.location_on,
                  ]
                      .map((IconData icon) => Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black38,
                            ),
                            child: Icon(icon),
                          ))
                      .toList(),
                  labelPadding: EdgeInsets.only(bottom: 5),
                ),
              )
            ];
          },
          body: TabBarView(children: [
            BlocProvider(
                blocSource: () => CharacterBloc(),
                builder: (BuildContext context, CharacterBloc bloc) {
                  bloc.loadFavouriteCharacters();
                  return StreamBuilder(
                      stream: bloc.favouriteCharactersStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        return snapshot.data == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : snapshot.data.isEmpty
                                ? Center(
                                    child: Text('No Favourite Character'),
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CharacterTile(
                                        character: Character.fromDB(
                                            snapshot.data[index]),
                                        forFavourite: true,
                                      );
                                    });
                      });
                }),
            BlocProvider(
                blocSource: () => EpisodeBloc(),
                builder: (BuildContext context, EpisodeBloc bloc) {
                  bloc.loadFavouriteEpisodes();
                  return StreamBuilder(
                      stream: bloc.favouriteEpisodesStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        return snapshot.data == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : snapshot.data.isEmpty
                                ? Center(
                                    child: Text('No Favourite Episode'),
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return EpisodeTile(
                                        episode: Episode.fromDB(
                                            snapshot.data[index]),
                                        forFavourite: true,
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                      );
                                    });
                      });
                }),
            BlocProvider(
                blocSource: () => LocationBloc(),
                builder: (BuildContext context, LocationBloc bloc) {
                  bloc.loadFavouriteLocations();
                  return StreamBuilder(
                      stream: bloc.favouriteLocationsStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        return snapshot.data == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : snapshot.data.isEmpty
                                ? Center(
                                    child: Text('No Favourite Location'),
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return LocationTile(
                                        location: Location.fromDB(
                                            snapshot.data[index]),
                                        forFavourite: true,
                                      );
                                    });
                      });
                }),
          ]),
        ),
      ),
    );
  }
}
