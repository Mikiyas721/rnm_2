import 'package:flutter/material.dart';
import 'package:rnm/utils/apiQuery.dart';
import './ui/pages/locationCharactersPage.dart';
import './ui/pages/locationsPage.dart';
import './ui/pages/characterEpisodesPage.dart';
import './ui/pages/characterPage.dart';
import './ui/pages/episodePage.dart';
import './ui/pages/homePage.dart';
import './injector.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      initialRoute: '/',
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => HomePage(),
  '/characterPage': (BuildContext context) => CharacterPage(),
  '/characterEpisodesPage': (BuildContext context) => CharacterEpisodesPage(),
  '/episodePage': (BuildContext context) => EpisodePage(),
  '/locationsPage': (BuildContext context) => LocationsPage(),
  '/locationCharactersPage': (BuildContext context) => LocationCharactersPage(),
};
