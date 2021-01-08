import 'package:flutter/material.dart';
import '../../ui/customWidgets/characterDialog.dart';
import '../../data/model/location.dart';

class LocationCharactersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Location location = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(location.residents[index].image),
          ),
          title: Text(location.residents[index].name),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CharacterDialog(
                    character: location.residents[index],
                  );
                });
          },
        );
      }),
    );
  }
}
