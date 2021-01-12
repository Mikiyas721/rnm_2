import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/model/location.dart';
import '../../utils/databaseManager.dart';
import '../../utils/apiQuery.dart';
import '../../utils/disposable.dart';
import 'episodeBloc.dart';

class LocationBloc extends Disposable {
  BehaviorSubject<List> _locations =
      GetIt.instance.get(instanceName: 'Locations');
  BehaviorSubject<List> _favouriteLocations =
      GetIt.instance.get(instanceName: 'FavouriteLocations');
  APIQuery _api = GetIt.instance.get(instanceName: 'Api');
  DatabaseManager _database = GetIt.instance.get(instanceName: 'Database');

  Stream<List> get locationsStream => _locations.map((event) => event);

  Stream<List> get favouriteLocationsStream =>
      _favouriteLocations.map((event) => event);

  Future<void> loadLocations() async {
    List locations = (await _api.getLocations()).data['locations']['results'];
    List<Map<String, dynamic>> saved = await loadFavouriteLocations();
    _locations.add(locations
        .map((map) =>
            {'data': map, 'isStarred': EpisodeBloc.hasThisKey(saved, map['id'])})
        .toList());
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
  void removeFromFavourite(String id)async{
    await _database.deleteFavouriteLocation(id);
    await loadLocations();
  }

  @override
  void dispose() {
    _locations.close();
    _favouriteLocations.close();
  }
}
