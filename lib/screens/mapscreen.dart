import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whitmaps/model/whitmap.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  WhitMap map;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _MapScreenState() {
    // center on Whitworth University
    map = new WhitMap(
      latitude: 47.753481,
      longitude: -117.417527,
      zoom: 13.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(map.latitude, map.longitude),
          zoom: map.zoom,
        )
    );
  }
} 