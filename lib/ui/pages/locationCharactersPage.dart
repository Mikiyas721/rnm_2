import 'package:flutter/material.dart';
import '../../ui/customWidgets/characterTile.dart';
import '../../data/model/location.dart';

class LocationCharactersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Location location = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: ListView.builder(
          itemCount: location.residents.length,
          itemBuilder: (BuildContext context, int index) {
            return CharacterTile(
              character: location.residents[index], forFavourite: false,
            );
          }),
    );
  }
}
