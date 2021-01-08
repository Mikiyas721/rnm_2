import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

void register() {
  GetIt instance = GetIt.instance;
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'Characters');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'RecentCharacters');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'Episodes');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'Locations');
}
