import 'package:flutter/material.dart';
import 'package:whitmaps/models/directory.dart';
import 'package:whitmaps/models/contact.dart';

final List<Contact> entries = Directory.getDirectoryList();


class ThirdFragment extends StatefulWidget {
  @override 
  ThirdFragmentState createState() => ThirdFragmentState();
}

class ThirdFragmentState extends State<ThirdFragment> {
  String formatPhone(Contact contact) {
    return "(" + contact.primaryPhone.substring(0,3) + ") " + contact.primaryPhone.substring(3,6) + "-" + contact.primaryPhone.substring(6,10);
  }

  void filterSearchResults(String query) {
    //to do (Nathaniel??)
  }

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.separated(
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.green[200],
                    padding: const EdgeInsets.fromLTRB(30,8,30,8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(entries[index].name, 
                          style: TextStyle(fontWeight: FontWeight.bold)
                          )
                        ),
                        RaisedButton(
                          onPressed: (){},
                          textColor: Colors.black, 
                          child: Text("Call " + formatPhone(entries[index])
                          )
                        )
                      ]
                    )
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}

//original version
  // Widget build(BuildContext context) {
  //   return new Center(
  //     child: new Scaffold(
  //       body: Center(
  //         child: ListView.separated(
  //         itemCount: entries.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Container(
  //             height: 50,
  //             color: Colors.green[200],
  //             padding: const EdgeInsets.fromLTRB(30,8,30,8),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Center(
  //                   child: Text(entries[index].name, 
  //                   style: TextStyle(fontWeight: FontWeight.bold)
  //                   )
  //                 ),
  //                 RaisedButton(
  //                   onPressed: (){},
  //                   textColor: Colors.black, 
  //                   child: Text("Call " + formatPhone(entries[index])
  //                   )
  //                 )
  //               ]
  //             )
  //           );
  //         },
  //         separatorBuilder: (BuildContext context, int index) => const Divider(),
  //       )
  //     ),
  //     ),
  //   );
  // }


//search version
  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //     body: Container(
  //       child: Column(
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: TextField(
  //               onChanged: (value) {
  //                 filterSearchResults(value);
  //               },
  //               controller: editingController,
  //               decoration: InputDecoration(
  //                   labelText: "Search",
  //                   hintText: "Search",
  //                   prefixIcon: Icon(Icons.search),
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(25.0)))),
  //             ),
  //           ),
  //           Expanded(
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: items.length,
  //               itemBuilder: (context, index) {
  //                 return ListTile(
  //                   title: Text('${items[index]}'),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );