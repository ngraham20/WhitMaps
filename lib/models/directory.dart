import 'dart:collection';
import 'package:sqflite/sqflite.dart';
import 'package:whitmaps/data/db.dart';
import 'package:whitmaps/models/contact.dart';

enum Transaction {
  addContact,
  removeContact
}

class DirHistory {
  final trans;
  final contact;

  const DirHistory(this.trans, this.contact);
}

class Directory {
  List<Contact> contacts;
  ListQueue<DirHistory> history;

  Directory({this.contacts});

  void addContact(Contact contact) {
    contacts.add(contact);
    history.add(DirHistory(Transaction.addContact, contact));
  }

  void removeContact(Contact contact) {
    contacts.remove(contact);
    history.add(DirHistory(Transaction.removeContact, contact));
  }

  void save() {
    Database db = DB.createDatabase();
    while (!history.isEmpty) {
      var transaction = history.removeFirst();
      if (transaction.trans == Transaction.addContact) {
        DB.createContact(db, transaction.contact);
      }
      else {
        DB.deleteContact(db, transaction.contact);
      }
    }
  }
}