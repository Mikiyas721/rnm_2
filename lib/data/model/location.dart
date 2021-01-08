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

  factory Location.fromJson(Map<String, dynamic> map) {
    return map??Location(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      dimension: map['dimension'],
      residents: Character.fromList(map['residents']),
      created: map['created'],
    );
  }
  static List<Location> fromList(List<Map<String, dynamic>> maps){
    return maps.map((map) => Location.fromJson(map)).toList();
  }
}
