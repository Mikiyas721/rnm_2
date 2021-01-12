import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/model/Episode.dart';
import '../../utils/databaseManager.dart';
import '../../utils/apiQuery.dart';
import '../../utils/disposable.dart';

class EpisodeBloc extends Disposable {
  BehaviorSubject _episodes = GetIt.instance.get(instanceName: 'Episodes');
  BehaviorSubject<List> _favouriteEpisodes =
      GetIt.instance.get(instanceName: 'FavouriteEpisodes');
  APIQuery _api = GetIt.instance.get(instanceName: 'Api');
  DatabaseManager _database = GetIt.instance.get(instanceName: 'Database');

  Stream<List> get episodesStream => _episodes.map((event) => event);

  Stream<List> get favouriteEpisodesStream =>
      _favouriteEpisodes.map((event) => event);

  Future<void> loadEpisodes() async {
    List episodes = (await _api.getEpisodes()).data['episodes']['results'];
    List<Map<String, dynamic>> saved = await loadFavouriteEpisodes();
    _episodes.add(episodes
        .map((map) => {
              'data': map,
              'isStarred': EpisodeBloc.hasThisKey(saved, map['id'])
            })
        .toList());
  }

  Future<List<Map<String, dynamic>>> loadFavouriteEpisodes() async {
    final result = await _database.fetchFavouriteEpisode();
    _favouriteEpisodes.add(result);
    return result;
  }

  Future<void> onStarTap(bool isActive, Episode episode) async {
    isActive
        ? await _database.addFavouriteEpisodes(episode)
        : await _database.deleteFavouriteEpisode(episode.id);
  }

  Future<void> removeFromFavourite(String id) async {
    await _database.deleteFavouriteEpisode(id);
    await loadEpisodes();
  }

  static bool hasThisKey(List<Map<String, dynamic>> saved, String id) {
    for (var map in saved) {
      if (map['id'] == id) return true;
    }
    return false;
  }

  @override
  void dispose() {
    _episodes.close();
    _favouriteEpisodes.close();
  }
}
