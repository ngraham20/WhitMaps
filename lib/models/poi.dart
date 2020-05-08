class Poi {
  double latitude;
  double longitude;
  String name;
  String description;
  String poiImage;
  String type;
  Poi({
    this.latitude,
    this.longitude,
    this.name,
    this.description,
    this.poiImage,
    this.type,
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
    Poi poi = new Poi();
    poi.name = "Eric Johnston Science Center";
    poi.longitude = null;
    poi.latitude = null;
    poi.description = "Home to the Math/CS, Physics, and part of the Biology department. Dedicated in 1966, this building houses the main labs for plant and animal biology, physics and the computer labs for CS classes, as well as the second largest lecture hall on campus.";
    poi.floorplanImagePath = null;
    poi.numParkingSpaces = null;
    return poi;
  }
  static Set<Poi> getPois() {
    return {
      Poi(latitude: 47.753481,
      longitude: -117.417527,
      name: "1",
      type: "OFFICE",
      ),
      Poi(latitude: 47.752671,
      longitude: -117.417714,
      name: "2",
      type: "RESIDENCE_HALL"),
    };
  }
}