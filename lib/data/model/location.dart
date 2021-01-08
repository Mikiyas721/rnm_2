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
    return Location(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      dimension: map['dimension'],
      residents: map['residents'],
      created: map['created'],
    );
  }
}
