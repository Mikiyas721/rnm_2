import 'character.dart';

class Location {
  String id;
  String name;
  String type;
  String dimension;
  List<Character> residents;
  String created;

  Location({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.created,
  });

  factory Location.fromAPI(Map<String, dynamic> map) {
    return map == null
        ? null
        : Location(
            id: map['id'],
            name: map['name'],
            type: map['type'],
            dimension: map['dimension'],
            residents: Character.fromList(map['residents']),
            created: map['created']);
  }

  factory Location.fromDB(Map<String, dynamic> map) {
    return map == null
        ? null
        : Location(
            id: map['id'],
            name: map['name'],
            type: map['type'],
            dimension: map['dimension'],
            residents: null,
            created: map['created'],
          );
  }

  static List<Location> fromList(List maps) {
    return maps == null
        ? null
        : maps.map((map) => Location.fromAPI(map)).toList();
  }
}
