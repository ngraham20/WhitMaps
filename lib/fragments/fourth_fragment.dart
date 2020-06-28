import 'package:flutter/material.dart';
import 'package:whitmaps/models/poi.dart';

final List<String> dummyPoiOffices = [
  "Pete Tucker 500",
  "Anne Trefry 100",
  "Kent Jones 330",
  "Matthew Bell 120",
];

class PoiScreenRoute extends MaterialPageRoute {

  Poi poi;

  PoiScreenRoute({this.poi}) : super(builder: (context) => new PoiScreen(poi: poi));
}

class PoiScreen extends StatelessWidget {

  Poi poi;
  PoiScreen({this.poi});

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
        
        body: FourthFragment(poi: this.poi)
      ),
      onWillPop: () {
        return new Future(() => true);
      },
    );
  }
}

class FourthFragment extends StatefulWidget {

  final Poi poi;
  const FourthFragment({this.poi});

  @override 
  FourthFragmentState createState() => FourthFragmentState();
}

class FourthFragmentState extends State<FourthFragment> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Scaffold(
        appBar: new AppBar(
          title: Text(widget.poi.name, style: TextStyle(color: Colors.white))
        ),
        body: Container(
          padding: EdgeInsets.all(10), 
          child: Column(
            children: <Widget>[
              // Container( //Poi name
              //   padding: EdgeInsets.all(10),
              //   color: Colors.red,
              //   child: Center(
              //     child: Text(Poi.getFakePOI().name, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold))
              //   )
              // ),
              // SizedBox(height: 8),
              Container( //building image
                padding: EdgeInsets.all(10),
                child:Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset(widget.poi.poiImage)
                    ],
                  )
                )
              ),
              SizedBox(height: 8),
              Container( //poi description
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red)
                ),
                child:Center(
                  child: Column(
                    children: <Widget>[
                      Text("Description", textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(widget.poi.description, textAlign: TextAlign.left)
                    ],
                  )
                )
              ),
              SizedBox(height: 8),
              // Container( //poi office directory
              //   padding: EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.greenAccent)
              //   ),
              //   child:Center(
              //     child: Column(
              //       children: <Widget>[
              //         Text("Office Directory", textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              //         Center(
              //           child: ListView.separated(
              //             itemCount: dummyPoiOffices.length,
              //             itemBuilder: (BuildContext context, int index) {
              //               return Container(
              //                 height: 50,
              //                 color: Colors.green[200],
              //                 padding: const EdgeInsets.fromLTRB(30,8,30,8),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Center(
              //                       child: Text(dummyPoiOffices[index],
              //                       style: TextStyle(fontWeight: FontWeight.bold)
              //                       )
              //                     ),
              //                   ]
              //                 )
              //               );
              //             },
              //             separatorBuilder: (BuildContext context, int index) => const Divider(),
              //           )
              //         ),
              //       ],
              //     )
              //   )
              // )
            ]
          ),
        )
      ),
    );
  }
}