import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whitmaps/models/whitmap.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  GoogleMapController mapController;
  WhitMap map;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    LatLng pinPosition = LatLng(
    map.latitude,
    map.longitude
   );
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('<MARKER_ID'),
          position: pinPosition,
          icon: pinLocationIcon
        )
      );
    });
  }

  @override
  void initState() {
      super.initState();
      setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/purplecheck.png');
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
      myLocationEnabled: true,
      markers: _markers,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(map.latitude, map.longitude),
        zoom: map.zoom,
      )
    );
  }
} 