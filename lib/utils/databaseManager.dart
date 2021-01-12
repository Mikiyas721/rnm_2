import '../data/model/Episode.dart';
import '../data/model/character.dart';
import '../data/model/location.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Database _database;

  Future<void> fireUpDatabase() async {
    _database = await openDatabase('Favourites.db');
  }

  Future<void> createTables() async {
    await _database.execute(
        'CREATE TABLE IF NOT EXISTS FavouriteCharacters (id VARCHAR,name VARCHAR,status VARCHAR,species VARCHAR,gender VARCHAR,origin VARCHAR,location VARCHAR,image VARCHAR,episode VARCHAR,created VARCHAR)');
    await _database.execute(
        'CREATE TABLE IF NOT EXISTS FavouriteLocations (id VARCHAR,name VARCHAR,type VARCHAR,dimension VARCHAR,residents VARCHAR,created VARCHAR)');
    await _database.execute(
        'CREATE TABLE IF NOT EXISTS FavouriteEpisodes (id VARCHAR,name VARCHAR,airDate VARCHAR,episode VARCHAR,characters VARCHAR,created VARCHAR)');
    await _database.execute(
        'CREATE TABLE IF NOT EXISTS RecentCharacters (id VARCHAR,name VARCHAR,status VARCHAR,species VARCHAR,gender VARCHAR,origin VARCHAR,location VARCHAR,image VARCHAR,episode VARCHAR,created VARCHAR,posted DATETIME)');
  }

  Future<int> addFavouriteCharacter(Character character) async {
    int count = await _database.rawInsert(
        'INSERT INTO FavouriteCharacters(id,name,status,species,gender,origin,location,image,episode,created) VALUES (?,?,?,?,?,?,?,?,?,?)',
        [
          character.id,
          character.name,
          character.status,
          character.species,
          character.gender,
          character.origin.name,
          character.location.name,
          character.image,
          character.episode.length,
          character.created,
        ]);
    return count;
  }

  Future<int> addRecentCharacter(Character character) async {
    int count = await _database.rawInsert(
        'INSERT INTO RecentCharacters(id,name,status,species,gender,origin,location,image,episode,created,posted) VALUES (?,?,?,?,?,?,?,?,?,?,?)',
        [
          character.id,
          character.name,
          character.status,
          character.species,
          character.gender,
          character.origin.name,
          character.location.name,
          character.image,
          character.episode.length,
          character.created,
          DateTime.now().toString()
        ]);
    return count;
  }

  Future<int> addFavouriteLocation(Location location) async {
    int count = await _database.rawInsert(
        'INSERT INTO FavouriteLocations(id ,name ,type ,dimension ,residents ,created) VALUES (?,?,?,?,?,?)',
        [
          location.id,
          location.name,
          location.type,
          location.dimension,
          location.residents.length,
          location.created
        ]);
    return count;
  }

  Future<int> addFavouriteEpisodes(Episode episode) async {
    int count = await _database.rawInsert(
        'INSERT INTO FavouriteEpisodes(id ,name ,airDate ,episode ,characters ,created) VALUES (?,?,?,?,?,?)',
        [
          episode.id,
          episode.name,
          episode.airDate,
          episode.episode,
          episode.characters.length,
          episode.created
        ]);
    return count;
  }

  Future<List<Map<String, dynamic>>> fetchFavouriteCharacters() async {
    List<Map<String, dynamic>> saved =
        await _database.rawQuery('SELECT * FROM FavouriteCharacters');
    return saved;
  }

  Future<List<Map<String, dynamic>>> fetchRecentCharacters() async {
    List<Map<String, dynamic>> saved =
        await _database.rawQuery('SELECT * FROM RecentCharacters ORDER BY posted DESC');
    return saved;
  }

  Future<List<Map<String, dynamic>>> fetchFavouriteLocations() async {
    List<Map<String, dynamic>> saved =
        await _database.rawQuery('SELECT * FROM FavouriteLocations');
    return saved;
  }

  Future<List<Map<String, dynamic>>> fetchFavouriteEpisode() async {
    List<Map<String, dynamic>> saved =
        await _database.rawQuery('SELECT * FROM FavouriteEpisodes');
    return saved;
  }

  Future<int> deleteFavouriteCharacter(String id) async {
    int count = await _database
        .rawDelete('DELETE FROM FavouriteCharacters WHERE id = ?', [id]);
    return count;
  }

  Future<int> deleteRecentCharacter(String id) async {
    int count = await _database
        .rawDelete('DELETE FROM RecentCharacters WHERE id = ?', [id]);
    return count;
  }

  Future<int> deleteFavouriteLocation(String id) async {
    int count = await _database
        .rawDelete('DELETE FROM FavouriteLocations WHERE id = ?', [id]);
    return count;
  }

  Future<int> deleteFavouriteEpisode(String id) async {
    int count = await _database
        .rawDelete('DELETE FROM FavouriteEpisodes WHERE id = ?', [id]);
    return count;
  }
}
