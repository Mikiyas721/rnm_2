import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/apiQuery.dart';
import '../../utils/disposable.dart';

class SearchBloc extends Disposable {
  APIQuery _api = GetIt.instance.get(instanceName: 'Api');
  BehaviorSubject<String> _searchElement =
      GetIt.instance.get(instanceName: 'SearchElement');
  BehaviorSubject<String> _searchProperty =
      GetIt.instance.get(instanceName: 'SearchProperty');
  BehaviorSubject<List> _searchData =
      GetIt.instance.get(instanceName: 'SearchData');

  Stream<String> get searchElementStream =>
      _searchElement.map((event) => event);

  Stream<List> get searchDataStream => _searchData.map((event) => event);

  String get currentSearchElement => _searchElement.value;

  String get currentSearchProperty => _searchProperty.value;

  void setDefaults() {
    _searchElement.add('People');
    _searchProperty.add('name');
  }

  void onSearchType(String key) {
    if (key == null || key == 'People')
      _searchElement.add('Episode');
    else if (key == 'Episode')
      _searchElement.add('Location');
    else if (key == 'Location') _searchElement.add('People');
    _searchProperty.add('name');
  }

  void onPropSelect(String selected) => _searchProperty.add(selected);

  List<Widget> getPopUps() {
    if (currentSearchElement == null || currentSearchElement == "People")
      return mapElements(['name', 'gender', 'species']);
    else if (currentSearchElement == "Episode")
      return mapElements(['name', 'episode']);
    else
      return mapElements(['name', 'dimension']);
  }

  List<Widget> mapElements(List<String> e) {
    return e
        .map((String e) => PopupMenuItem(
              child: Text(e),
              value: e,
            ))
        .toList();
  }

  void onSearch(String enteredValue) async {
    if (currentSearchElement == "People")
      _searchData.add((await _api.getCharactersWithFilter(
              currentSearchProperty, enteredValue))
          .data['characters']['results']);
    else if (currentSearchElement == "Episode")
      _searchData.add((await _api.getEpisodesWithFilter(
              currentSearchProperty, enteredValue))
          .data['episodes']['results']);
    else if (currentSearchElement == "Location")
      _searchData.add((await _api.getLocationsWithFilter(
              currentSearchProperty, enteredValue))
          .data['locations']['results']);
    else
      throw Exception('Search Element not found');
  }

  @override
  void dispose() {
    _searchElement.close();
    _searchProperty.close();
    _searchData.close();
  }
}
