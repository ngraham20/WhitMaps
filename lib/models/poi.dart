import 'package:sqflite/sqflite.dart';
import 'package:whitmaps/data/db.dart';

class Poi {
  double latitude;
  double longitude;
  String name;
  String description;
  String poiImage;
  String type;
  bool   interactive;
  Poi({
    this.latitude,
    this.longitude,
    this.name,
    this.description,
    this.poiImage,
    this.type,
    this.interactive
  });

  factory Poi.fromJson(Map<String, dynamic> data) => new Poi(
    latitude: data["latitude"],
    longitude: data["longitude"],
    name: data["name"],
    description: data["description"],
    poiImage: data["poi_image"],
    type: data["type"],
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "description": description,
    "poi_image": poiImage,
    "type": type,
  };

  static Poi getFakePOI() {
    return Poi(
      name: "Eric Johnson Science Center",
      latitude: 47.753481,
      longitude: -117.417527,
      type: "OFFICE",
      interactive: true,
      description: "Home to the Math/CS, Physics, and part of the Biology department. Dedicated in 1966, this building houses the main labs for plant and animal biology, physics and the computer labs for CS classes, as well as the second largest lecture hall on campus."
    );
  }
  static Future<List<Poi>> getPois(db) async {
    List<Poi> result = [];
    var pois = await DB.getAllPois(db);
    for (var item in pois) {
      result.add(Poi.fromJson(item));
    }
    return result;
  }
}