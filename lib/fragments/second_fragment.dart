import 'package:flutter/material.dart';

final List<String> entries = <String>['Main Phone', 'Security', 'Facilities'];
final List<int> colorCodes = <int>[600, 500, 100];

class SecondFragment extends StatefulWidget {
  @override 
  SecondFragmentState createState() => SecondFragmentState();
}

class SecondFragmentState extends State<SecondFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Scaffold(
        body: Center(
          child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(child: Text('${entries[index]}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
      ),
      ),
    );
  }
}



