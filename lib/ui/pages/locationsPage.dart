import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../ui/customWidgets/favouriteIcon.dart';
import '../../data/model/location.dart';
import '../../ui/customWidgets/myText.dart';
import '../../data/bloc/locationBloc.dart';
import '../../data/bloc/provider/provider.dart';

class LocationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Locations'),
        ),
        body: BlocProvider(
            blocSource: () => LocationBloc(),
            onInit: (LocationBloc bloc) {
              bloc.loadLocations();
            },
            builder: (BuildContext context, LocationBloc bloc) {
              return StreamBuilder(
                  stream: bloc.locationsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    return snapshot.data == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : snapshot.data['list'].isNotEmpty &&
                                snapshot.data['list'][0] == null
                            ? Center(
                                child: IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: () {
                                  bloc.loadLocations();
                                },
                              ))
                            : ListView(
                                children: [
                                  ExpansionPanelList(
                                    expandedHeaderPadding:
                                        EdgeInsets.symmetric(vertical: 8),
                                    expansionCallback:
                                        (int index, bool isExpanded) {
                                      isExpanded
                                          ? bloc.updateEnabledIndex(-1)
                                          : bloc.updateEnabledIndex(index);
                                    },
                                    children: List.generate(
                                        snapshot.data['list'].length,
                                        (int index) {
                                      Location location = Location.fromAPI(
                                          snapshot.data['list'][index]['data']);
                                      return ExpansionPanel(
                                        headerBuilder:
                                            (BuildContext context, bool value) {
                                          return ListTile(
                                            leading: TwoStateIconButton(
                                              inActiveIcon: Icon(
                                                Icons.star_border,
                                                color: Colors.grey.shade500,
                                                size: 30,
                                              ),
                                              onTap: (bool isActive) async {
                                                await bloc.onStarTap(
                                                    isActive, location);
                                              },
                                              isActive: snapshot.data['list']
                                                  [index]['isStarred'],
                                              activeIcon: Icon(
                                                Icons.star,
                                                color: Colors.yellow.shade500,
                                                size: 30,
                                              ),
                                            ),
                                            title: Text(location.name),
                                          );
                                        },
                                        body: Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                label: 'Type',
                                                value: location.type,
                                                padding: EdgeInsets.all(0),
                                              ),
                                              MyText(
                                                label: 'Created',
                                                value: DateFormat('dd-mm-yyyy')
                                                    .format(DateTime.parse(
                                                        location.created)),
                                                padding: EdgeInsets.all(0),
                                              ),
                                              MyText(
                                                label: 'Dimension',
                                                value: location.dimension,
                                                padding: EdgeInsets.all(0),
                                              ),
                                              SizedBox(height: 20),
                                              Center(
                                                child: RaisedButton(
                                                  padding: EdgeInsets.only(
                                                      left: 70,
                                                      right: 70,
                                                      top: 10,
                                                      bottom: 10),
                                                  color: Colors.blue.shade400,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/locationCharactersPage',
                                                        arguments: location);
                                                  },
                                                  child: Text(
                                                    '${location.residents.length} Resident(s)',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10)
                                            ],
                                          ),
                                        ),
                                        isExpanded:
                                            snapshot.data['enabledIndex'] ==
                                                    index
                                                ? true
                                                : false,
                                        canTapOnHeader: true,
                                      );
                                    }),
                                  ),
                                ],
                              );
                  });
            }));
  }
}
