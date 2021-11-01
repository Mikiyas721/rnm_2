import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/model/location.dart';
import '../../utils/databaseManager.dart';
import '../../utils/apiQuery.dart';
import '../../utils/disposable.dart';
import 'episodeBloc.dart';

class LocationBloc extends Disposable {
  BehaviorSubject<Map> _locations =
      GetIt.instance.get(instanceName: 'Locations');
  BehaviorSubject<List> _favouriteLocations =
      GetIt.instance.get(instanceName: 'FavouriteLocations');

  APIQuery _api = GetIt.instance.get(instanceName: 'Api');
  DatabaseManager _database = GetIt.instance.get(instanceName: 'Database');

  Stream<Map<String, dynamic>> get locationsStream => _locations.map((event) => event);

  int get enabledIndex => _locations.value['enabledIndex'];

  List get locations => _locations.value['list'];

  Stream<List> get favouriteLocationsStream =>
      _favouriteLocations.map((event) => event);

  Future<void> loadLocations() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _locations.add({
        'list': [null],
        'enabledIndex': -1
      });
    } else {
      List locations = (await _api.getLocations()).data['locations']['results'];
      List<Map<String, dynamic>> saved = await loadFavouriteLocations();
      _locations.add(Map<String, dynamic>.from({
        'list': locations
            .map((map) => {
                  'data': map,
                  'isStarred': EpisodeBloc.hasThisKey(saved, map['id'])
                })
            .toList(),
        'enabledIndex': _locations.value==null?-1:enabledIndex
      }));
    }
  }

  void updateEnabledIndex(int enabledIndex){
    _locations.add(Map<String, dynamic>.from({
      'list': locations,
      'enabledIndex': enabledIndex
    }));
  }

  Future<List<Map<String, dynamic>>> loadFavouriteLocations() async {
    final result = await _database.fetchFavouriteLocations();
    _favouriteLocations.add(result);
    return result;
  }

  Future<void> onStarTap(bool isActive, Location location) async {
    isActive
        ? await _database.addFavouriteLocation(location)
        : await _database.deleteFavouriteLocation(location.id);
  }

  void removeFromFavourite(String id) async {
    await _database.deleteFavouriteLocation(id);
    await loadLocations();
  }

  @override
  void dispose() {
    _locations.close();
    _favouriteLocations.close();
  }
}
