import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './ui/pages/favouritePage.dart';
import './utils/databaseManager.dart';
import './ui/pages/locationCharactersPage.dart';
import './ui/pages/locationsPage.dart';
import './ui/pages/characterEpisodesPage.dart';
import './ui/pages/characterPage.dart';
import './ui/pages/episodePage.dart';
import './ui/pages/homePage.dart';
import './injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  register();
  DatabaseManager database = GetIt.instance.get(instanceName: 'Database');
  await database.fireUpDatabase();
  await database.createTables();
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
  '/favouritePage': (BuildContext context) => FavouritePage(),
};
