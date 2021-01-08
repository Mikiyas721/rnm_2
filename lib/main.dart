import 'package:flutter/material.dart';
import './injector.dart';
import './ui/pages/characterEpisodesPage.dart';
import './ui/pages/characterPage.dart';
import './ui/pages/episodePage.dart';
import './ui/pages/homePage.dart';

void main() {
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
};
