import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/disposable.dart';

class LocationBloc extends Disposable {
  BehaviorSubject _locations = GetIt.instance.get(instanceName: 'Locations');

  Stream<List> get locationsStream => _locations.map((event) => event);

  @override
  void dispose() {}
}
