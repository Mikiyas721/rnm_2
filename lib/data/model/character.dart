import 'Episode.dart';
import 'location.dart';

class Character {
  String id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Location origin;
  Location location;
  String image;
  List<Episode> episode;
  String created;

  Character(
      {this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.origin,
      this.location,
      this.image,
      this.episode,
      this.created});

  factory Character.fromAPI(Map<String, dynamic> map) {
    return map == null
        ? null
        : Character(
            id: map['id'],
            name: map['name'],
            status: map['status'],
            species: map['species'],
            type: map['type'],
            gender: map['gender'],
            origin: Location.fromAPI(map['origin']),
            location: Location.fromAPI(map['location']),
            image: map['image'],
            episode: Episode.fromList(map['episode']),
            created: map['created']);
  }

  factory Character.fromDB(Map<String, dynamic> map) {
    return map == null
        ? null
        : Character(
            id: map['id'],
            name: map['name'],
            status: map['status'],
            species: map['species'],
            type: map['type'],
            gender: map['gender'],
            origin: Location(name: map['location']),
            location: Location(name: map['location']),
            image: map['image'],
            episode: null,
            created: map['created']);
  }

  static List<Character> fromList(List maps) {
    return maps == null
        ? null
        : maps.map((map) => Character.fromAPI(map)).toList();
  }
}
