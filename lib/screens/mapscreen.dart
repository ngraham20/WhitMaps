import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  BitmapDescriptor yahPin;
  Set<Marker> _markers = {};
  Set<Poi> _pois = {};
  GoogleMapController mapController;
  WhitMap map;
  Position _currentPosition;

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
              Navigator.of(context).push(new PoiScreenRoute());
            }
          )
        );
      });
    }

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("YOUAREHERE"),
          position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          icon: defaultPin
        )
      );
    });
  }

void updateYAH(id, latitude, longitude){

  final marker = _markers.firstWhere((item) => item.markerId == id);

  Marker _marker = Marker(
    markerId: marker.markerId,
    onTap: marker.onTap,
    position: LatLng(latitude, longitude),
    icon: marker.icon,
  );

  setState(() {
  //the marker is identified by the markerId and not with the index of the list
    _markers.remove(marker);
    _markers.add(_marker);
  });
}

  @override
  void initState() {
      super.initState();
      setOfficePin();
      setRHPin();
      setDefaultPin();
      _pois = Poi.getPois();
  }

  void inityahPin() {
    setState(() {
<<<<<<< HEAD
      Timer.periodic(Duration(seconds: 3), (Timer t) => setState((){
        _getCurrentLocation();
      }));
=======
      Timer.periodic(Duration(seconds: 3), (Timer t) => setState((){}));
>>>>>>> 2321fda3626a4b0c936c6c0e17cf587a2c96ef4a
    });
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

  void setYAHPin() async {
    yahPin = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/purplecheck.png');
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
        setState(() {
          _currentPosition = position;
        });
      }).catchError((e) {
        print(e);
      });
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