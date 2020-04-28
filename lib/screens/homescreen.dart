import 'package:flutter/material.dart';
import 'package:whitmaps/fragments/first_fragment.dart';
import 'package:whitmaps/fragments/fourth_fragment.dart';
import 'package:whitmaps/fragments/second_fragment.dart';
import 'package:whitmaps/fragments/third_fragment.dart';
import 'package:whitmaps/screens/mapscreen.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("WhitMaps", Icons.map),
    new DrawerItem("Phone Book", Icons.phone),
    new DrawerItem("Directory", Icons.contacts),
    new DrawerItem("Sign Out", Icons.person)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FirstFragment();
      case 1:
        return new SecondFragment();
      case 2:
        return new ThirdFragment();
      case 3:
        return new FourthFragment();

      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Pete Tucker"), accountEmail: null),
            new Column(children: drawerOptions)
        
          ],
        ),
      ),
      body: Center(
        child: MapScreen(),
      ),
    );
  }
}













// class BottomNavDrawer extends StatefulWidget {
//   BottomNavDrawer({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   BottomNavDrawerState createState() {
//     return new BottomNavDrawerState();
//   }
// }

// class BottomNavDrawerState extends State<BottomNavDrawer> {
//   static final List<String> _listViewData = [
//     "Search for a location",
//     "Route to Location",
//     "Phone book"
//   ];

//   int _selectedIndex = 0;
//   static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Menu',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 1: Schedule',
//       style: optionStyle,
//     ),
//   ];

//   _showDrawer(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//             child: ListView(
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: _listViewData
//                       .map((data) => ListTile(
//                     title: Text(data),
//                   ))
//                       .toList(),
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("WhitMaps Home"),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu),
//             title: Text('Menu'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             title: Text('Schedule'),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _showDrawer,
//       ),
//       body: Center(
//         child: MapScreen(),
//       ),

// //
//     );
//   }
// }


