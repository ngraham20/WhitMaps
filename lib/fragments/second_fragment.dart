import 'package:flutter/material.dart';
import 'package:whitmaps/models/directory.dart';
import 'package:whitmaps/models/contact.dart';

final List<Contact> entries = Directory.getPhoneBookList();


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
      ),
    );
  }
  
  String formatPhone(Contact contact) {
    return "(" + contact.primaryPhone.substring(0,3) + ") " + contact.primaryPhone.substring(3,6) + "-" + contact.primaryPhone.substring(6,10);
  }
}




  