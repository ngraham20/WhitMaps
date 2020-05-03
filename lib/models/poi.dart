import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Poi {
  double latitude;
  double longitude;
  String name;
  String description;
  String floorplanImagePath;
  int numParkingSpaces;
  BitmapDescriptor pinLocationIcon;

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

  Marker toMarker() {
    return Marker(
      markerId: MarkerId('<MARKER_ID'),
      position: LatLng(latitude, longitude),
      icon: pinLocationIcon
    );
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/purplecheck.png');
  }
}