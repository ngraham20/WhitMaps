import 'package:flutter/material.dart';
import 'package:whitmaps/screens/mapscreen.dart';

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

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Menu',
      style: optionStyle,
    ),
    Text(
      'Index 1: Schedule',
      style: optionStyle,
    ),
  ];

  _showDrawer(int index) {
    setState(() {
      _selectedIndex = index;
    });

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

      body: Center(
        child: MapScreen(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('Menu'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Schedule'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _showDrawer,
      ),
    );
  }
}

