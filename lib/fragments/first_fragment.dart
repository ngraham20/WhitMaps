import 'package:flutter/material.dart';
import 'package:whitmaps/screens/mapscreen.dart';

class FirstFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Scaffold(
        body: Center(
          child: MapScreen(),
        ),
      ),
    );
  }


}

