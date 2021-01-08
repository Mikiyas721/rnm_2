import 'package:flutter/material.dart';
import './ui/pages/homePage.dart';

void main() {
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

final routes = {'/': (BuildContext context) => HomePage()};
