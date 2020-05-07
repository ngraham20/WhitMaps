class Poi {
  double latitude;
  double longitude;
  String name;
  String description;
  String floorplanImagePath;
  int numParkingSpaces;

  Poi({
    this.latitude,
    this.longitude,
    this.name,
    this.description,
    this.floorplanImagePath,
    this.numParkingSpaces
  });

  factory Poi.fromJson(Map<String, dynamic> data) => new Poi(
    latitude: data["latitude"],
    longitude: data["longitude"],
    name: data["name"],
    description: data["description"],
    floorplanImagePath: data["floorplanImagePath"],
    numParkingSpaces: data["numParkingSpaces"],
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "description": description,
    "floorplanImagePath": floorplanImagePath,
    "numParkingSpaces": numParkingSpaces,
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
}