import 'package:get_it/get_it.dart';
import 'package:rnm/data/model/character.dart';
import 'package:rnm/utils/apiQuery.dart';
import 'package:rnm/utils/databaseManager.dart';
import 'package:rxdart/rxdart.dart';
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

  void loadCharacters() async {
    _character.add((await _api.getCharacters()).data['characters']['results']);
  }

  void loadFavouriteCharacters() async {
    _favouriteCharacters.add(await _database.fetchFavouriteCharacters());
  }

  Future<void> loadRecentCharacters() async {
    _recentCharacters.add(await _database.fetchRecentCharacters());
  }

  Future<void> onStarTap(bool isActive, Character character) async {
    isActive
        ? await _database.addFavouriteCharacter(character)
        : await _database.deleteFavouriteCharacter(character.id);
  }

  Future<void> addRecentCharacter(Character character) async {
    await _database.addRecentCharacter(character);
  }

  @override
  void dispose() {
    _character.close();
    _recentCharacters.close();
    _favouriteCharacters.close();
  }
}
