import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whitmaps/models/poi.dart';
import 'package:whitmaps/models/whitmap.dart';
import 'package:whitmaps/fragments/fourth_fragment.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  BitmapDescriptor officeIcon;
  BitmapDescriptor rhIcon;
  BitmapDescriptor defaultPin;
  Set<Marker> _markers = {};
  Set<Poi> _pois = {};
  GoogleMapController mapController;
  WhitMap map;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    for (var poi in _pois) {
      var icon;
      switch (poi.type) {
        case "OFFICE":
          icon = officeIcon;
          break;
        case "RESIDENCE_HALL":
          icon = rhIcon;
          break;
        default:
          icon = defaultPin;
          break;
        }

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(poi.name),
            position: LatLng(poi.latitude, poi.longitude),
            icon: icon,
            onTap: () {
              if (poi.interactive == true) {
                Navigator.of(context).push(new PoiScreenRoute());
              }
            }
          )
        );
      });
    }
  }

  @override
  void initState() {
      super.initState();
      setOfficePin();
      setRHPin();
      setDefaultPin();
      _pois = Poi.getPois();
  }

  void setOfficePin() async {
    officeIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/office-32.png');
  }

  void setRHPin() async {
    rhIcon = await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(devicePixelRatio: 2.5),
    'assets/residence-hall-32.png');
  }

  void setDefaultPin() async {
    defaultPin = await BitmapDescriptor.fromAssetImage(
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