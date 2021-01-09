import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import '../../utils/apiQuery.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/disposable.dart';

class LocationBloc extends Disposable {
  BehaviorSubject _locations = GetIt.instance.get(instanceName: 'Locations');
  APIQuery _api = GetIt.instance.get(instanceName: 'Api');

  Stream<List> get locationsStream => _locations.map((event) => event);

  void loadLocations() async {
    _locations.add((await _api.getLocations()).data['locations']['results']);
  }

  @override
  void dispose() {}
}
