import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:whitmaps/models/poi.dart';
import 'package:whitmaps/models/whitmap.dart';
import 'package:whitmaps/fragments/fourth_fragment.dart';
import 'package:whitmaps/data/db.dart';

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
  List<Poi> _pois = [];
  GoogleMapController mapController;
  WhitMap map;
  Position _currentPosition;
  // DB _db;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

// void updateYAH(){


//   _getCurrentLocation();
//   final marker = _markers.firstWhere((item) => item.markerId == MarkerId("YOUAREHERE"));

//   Marker _marker = Marker(
//     markerId: marker.markerId,
//     onTap: marker.onTap,
//     position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
//     icon: marker.icon,
//   );

//   setState(() {
//   //the marker is identified by the markerId and not with the index of the list
//     _markers.remove(marker);
//     _markers.add(_marker);
//   });
// }

  @override
  void initState() {
      super.initState();
      setOfficePin();
      setRHPin();
      setDefaultPin();
      inityahPin();
      DB.createDatabase().then((value) {
         Poi.getPois(value).then((pval) {
            for (var poi in pval) {
              var icon;
              switch (poi.type) {
                case "OFFICE":
                  icon = officeIcon;
                  break;
                case "RESIDENCE_HALL":
                  icon = rhIcon;
                  break;
                case "ACADEMIC":
                  icon = officeIcon;
                  break;
                case "HUB":
                  icon = officeIcon;
                  break;
                case "LIBRARY":
                  icon = officeIcon;
                  break;
                case "CHURCH":
                  icon = officeIcon;
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
                      Navigator.of(context).push(new PoiScreenRoute(poi: poi));
                    }
                  )
                );
              });
            }
         });
      });
  }

  void inityahPin() {
    new Timer.periodic(Duration(seconds: 3), (Timer t) {
        _getCurrentLocation();
      // updateYAH();
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
      zoom: 16,
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