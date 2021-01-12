import 'package:get_it/get_it.dart';
import 'package:rnm/data/model/location.dart';
import 'package:rnm/utils/databaseManager.dart';
import '../../utils/apiQuery.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/disposable.dart';

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

  void loadLocations() async {
    _locations.add((await _api.getLocations()).data['locations']['results']);
  }

  void loadFavouriteLocations()async {
    _favouriteLocations.add(await _database.fetchFavouriteLocations());
  }

  Future<void> onStarTap(bool isActive, Location location) async {
    isActive
        ? await _database.addFavouriteLocation(location)
        : await _database.deleteFavouriteLocation(location.id);
  }

  @override
  void dispose() {
    _locations.close();
    _favouriteLocations.close();
  }
}
