import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/bloc/episodeBloc.dart';
import '../../data/model/character.dart';
import '../../utils/apiQuery.dart';
import '../../utils/databaseManager.dart';
import '../../utils/disposable.dart';

class CharacterBloc extends Disposable {
  BehaviorSubject<List> _character =
      GetIt.instance.get(instanceName: 'Characters');
  BehaviorSubject<List> _recentCharacters =
      GetIt.instance.get(instanceName: 'RecentCharacters');
  BehaviorSubject<List> _favouriteCharacters =
      GetIt.instance.get(instanceName: 'FavouriteCharacters');
  APIQuery _api = GetIt.instance.get(instanceName: 'Api');
  DatabaseManager _database = GetIt.instance.get(instanceName: 'Database');

  Stream<List> get characterStream => _character.map((event) => event);

  Stream<List> get recentCharacterStream =>
      _recentCharacters.map((event) => event);

  Stream<List> get favouriteCharactersStream =>
      _favouriteCharacters.map((event) => event);

  Future<void> loadCharacters() async {
    List characters =
        (await _api.getCharacters()).data['characters']['results'];
    List<Map<String, dynamic>> saved = await loadFavouriteCharacters();
    _character.add(characters
        .map((map) => {
              'data': map,
              'isStarred': EpisodeBloc.hasThisKey(saved, map['id'])
            })
        .toList());
  }

  Future<List<Map<String, dynamic>>> loadFavouriteCharacters() async {
    final result = await _database.fetchFavouriteCharacters();
    _favouriteCharacters.add(result);
    return result;
  }

  Future<void> loadRecentCharacters() async {
    _recentCharacters.add(await _database.fetchRecentCharacters());
  }

  Future<void> onStarTap(bool isActive, Character character) async {
    isActive
        ? await _database.addFavouriteCharacter(character)
        : await _database.deleteFavouriteCharacter(character.id);
    await loadCharacters();
  }

  Future<void> addRecentCharacter(Character character) async {
    List<Map<String, dynamic>> recent = await _database.fetchRecentCharacters();
    if (!(recent[0]['id'] == character.id)) {
      await _database.addRecentCharacter(character);
      _database.limitRecent();
    }
  }

  void removeFromFavourite(String id) async {
    await _database.deleteFavouriteCharacter(id);
    await loadCharacters();
  }

  @override
  void dispose() {
    _character.close();
    _recentCharacters.close();
    _favouriteCharacters.close();
  }
}
