class WhitMap {
  double longitude;
  double latitude;
  double zoom;

  WhitMap({
    this.longitude,
    this.latitude,
    this.zoom
  });

  factory WhitMap.fromJson(Map<String, dynamic> data) => new WhitMap(
    longitude: data["longitude"],
    latitude: data["latitude"],
    zoom: data["zoom"]
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
    "zoom": zoom
  };
}