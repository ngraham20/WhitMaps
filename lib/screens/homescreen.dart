import 'package:flutter/material.dart';

class BottomNavDrawer extends StatefulWidget {
  BottomNavDrawer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  BottomNavDrawerState createState() {
    return new BottomNavDrawerState();
  }
}

class BottomNavDrawerState extends State<BottomNavDrawer> {
  static final List<String> _listViewData = [
    "Search for a location",
    "Route to Location",
    "Phone book"
  ];

  _showDrawer() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _listViewData
                      .map((data) => ListTile(
                    title: Text(data),
                  ))
                      .toList(),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhitMaps Home"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          height: 50.0,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: _showDrawer,
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Google Map here'),
      ),
    );
  }
}

