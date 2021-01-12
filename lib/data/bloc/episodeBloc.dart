import 'package:get_it/get_it.dart';
import 'package:rnm/data/model/Episode.dart';
import 'package:rnm/utils/databaseManager.dart';
import 'package:rxdart/rxdart.dart';
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

  void loadEpisodes() async {
    _episodes.add((await _api.getEpisodes()).data['episodes']['results']);
  }

  Future<List<Map<String,dynamic>>> loadFavouriteEpisodes() async {
    final result = await _database.fetchFavouriteEpisode();
    _favouriteEpisodes.add(result);
    return result;
  }

  Future<void> onStarTap(bool isActive, Episode episode) async {
    isActive
        ? await _database.addFavouriteEpisodes(episode)
        : await _database.deleteFavouriteEpisode(episode.id);
  }

  @override
  void dispose() {
    _episodes.close();
    _favouriteEpisodes.close();
  }
}
