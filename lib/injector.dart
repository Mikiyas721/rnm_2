import 'package:get_it/get_it.dart';
import './utils/apiQuery.dart';
import './utils/databaseManager.dart';
import 'package:rxdart/rxdart.dart';

void register() {
  GetIt instance = GetIt.instance;
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'Characters');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'RecentCharacters');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'FavouriteCharacters');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'Episodes');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'FavouriteEpisodes');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'Locations');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'FavouriteLocations');

  instance.registerLazySingleton(() => BehaviorSubject<String>(),instanceName: 'SearchElement');
  instance.registerLazySingleton(() => BehaviorSubject<String>(),instanceName: 'SearchProperty');
  instance.registerLazySingleton(() => BehaviorSubject<List>(),instanceName: 'SearchData');

  instance.registerLazySingleton(() =>  APIQuery(),instanceName: 'Api');
  instance.registerSingleton<DatabaseManager>(DatabaseManager(),instanceName: 'Database');
}
