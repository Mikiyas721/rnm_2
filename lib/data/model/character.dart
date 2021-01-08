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

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.created
  });

  factory Character.fromJson(Map<String, dynamic> map){
    return Character(
        id: map['id'],
        name: map['name'],
        status: map['status'],
        species: map['species'],
        type: map['type'],
        gender: map['gender'],
        origin: map['origin'],
        location: map['location'],
        image: map['image'],
        episode: map['episode'],
        created: map['created']
    );
  }
}