import 'package:flutter/material.dart';
import 'package:whitmaps/models/directory.dart';
import 'package:whitmaps/models/contact.dart';
import 'package:url_launcher/url_launcher.dart';

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
              //color: Colors.red[200],
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
                    onPressed: () => _makeCall(entries[index].primaryPhone),
                    color: Colors.red,
                    textColor: Colors.white, 
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

  _makeCall(String phone) async {
    final url = 'tel://$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
  String formatPhone(Contact contact) {
    return "(" + contact.primaryPhone.substring(0,3) + ") " + contact.primaryPhone.substring(3,6) + "-" + contact.primaryPhone.substring(6,10);
  }
}




  