import 'character.dart';

class Episode {
  String id;
  String name;
  String airDate;
  String episode;
  List<Character> characters;
  String created;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> map) {
    return map==null?null:Episode(
      id: map['id'],
      name: map['name'],
      airDate: map['air_date'],
      episode: map['episode'],
      characters: Character.fromList(map['characters']),
      created: map['created'],
    );
  }
  static List<Episode> fromList(List maps){
    return maps==null?null:maps.map((map) => Episode.fromJson(map)).toList();
  }
}
