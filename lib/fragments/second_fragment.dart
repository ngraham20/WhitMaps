import 'package:flutter/material.dart';
import 'package:whitmaps/models/directory.dart';
import 'package:whitmaps/models/contact.dart';

final List<Contact> entries = Directory.getPhoneDirectory();


class SecondFragment extends StatefulWidget {
  @override 
  SecondFragmentState createState() => SecondFragmentState();
}

class SecondFragmentState extends State<SecondFragment> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Scaffold(
        body: Center(
          child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.green[200],
              child: Center(child: Text(formatContactInfo(entries[index]),style: TextStyle(fontWeight: FontWeight.bold))),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
      ),
      ),
    );
  }
  String formatContactInfo(Contact contact) {
    return contact.name + "  Ext. " + contact.primaryPhone.substring(6,10);
  }
}




  