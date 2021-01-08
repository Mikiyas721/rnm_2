import 'package:flutter/material.dart';
import 'package:rnm/data/bloc/locationBloc.dart';
import 'package:rnm/data/bloc/provider/provider.dart';
import 'package:rnm/data/model/location.dart';

class LocationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  int expandedTileIndex;

  @override
  void initState() {
    expandedTileIndex = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Locations'),
        ),
        body: BlocProvider(
            blocSource: () => LocationBloc(),
            builder: (BuildContext context, LocationBloc bloc) {
              return StreamBuilder(
                  stream: bloc.locationsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List> snapshot) {
                    return snapshot.data == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ExpansionPanelList(
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                isExpanded
                                    ? expandedTileIndex = index
                                    : expandedTileIndex = -1;
                              });
                            },
                            children: List.generate(snapshot.data.length,
                                (int index) {
                              return ExpansionPanel(
                                headerBuilder:
                                    (BuildContext context, bool value) {
                                  return ListTile(
                                    leading: Icon(Icons.location_on),
                                    title: Text('${snapshot.data[index].name}'),
                                    trailing: IconButton(
                                        icon: Icon(Icons.star),
                                        onPressed: () {}),
                                  );
                                },
                                body: Column(
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(text: 'Type: '),
                                      TextSpan(text: snapshot.data[index].type)
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(text: 'Created: '),
                                      TextSpan(
                                          text: snapshot.data[index].created)
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(text: 'Dimension: '),
                                      TextSpan(
                                          text: snapshot.data[index].dimension)
                                    ])),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/locationCharactersPage',
                                            arguments: snapshot.data[index]);
                                      },
                                      child: Text(
                                          '${snapshot.data[index].residents.length} Residents'),
                                    )
                                  ],
                                ),
                                isExpanded:
                                    expandedTileIndex == index ? true : false,
                                canTapOnHeader: true,
                              );
                            }),
                          );
                  });
            }));
  }
}
