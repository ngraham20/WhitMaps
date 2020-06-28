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

  // void save() {
  //   Database db = DB.createDatabase();
  //   while (!history.isEmpty) {
  //     var transaction = history.removeFirst();
  //     if (transaction.trans == Transaction.addContact) {
  //       DB.createContact(db, transaction.contact);
  //     }
  //     else {
  //       DB.deleteContact(db, transaction.contact);
  //     }
  //   }
  // }
  //alphabetize??
  //these are accurate phone numbers
  static List<Contact> getPhoneBookList() {
    List<Contact> importantPlacesList = [
      new Contact.phoneDirectory("Main Office", "5097771000"),
      new Contact.phoneDirectory("Campus Security", "5097774444"),
      new Contact.phoneDirectory("Facilities", "5097773254"),
      new Contact.phoneDirectory("Registrar", "5097773205"),
      new Contact.phoneDirectory("Student Life", "5097773271"),
      new Contact.phoneDirectory("Post Office", "5097773279"),
      new Contact.phoneDirectory("Housing Office", "5097774533"),
      new Contact.phoneDirectory("Health Center", "5097773259"),
      new Contact.phoneDirectory("HUB Info Desk", "5097773796"),
      new Contact.phoneDirectory("Student Accounting", "5097774340"),
      new Contact.phoneDirectory("IT Help Desk", "5097773911"),
      new Contact.phoneDirectory("Library", "5097773260"),
      new Contact.phoneDirectory("URec", "5097773734"),
      new Contact.phoneDirectory("Aquatic Center", "5097774778")
    ];
    return importantPlacesList;
  }

  //these are NOT accurate phone numbers
  static List<Contact> getDirectoryList() {
    List<Contact> directoryList = [
      new Contact.phoneDirectory("Anne Trefry", "5097773271"),
      new Contact.phoneDirectory("Matthew Bell", "5097773254"),
      new Contact.phoneDirectory("Pete Tucker", "5097773205"),
      new Contact.phoneDirectory("Nathaniel Graham", "5097773279"),
      new Contact.phoneDirectory("Kelly Olivier", "5097774533"),
      new Contact.phoneDirectory("Paul MacDonald", "5097773259"),
      new Contact.phoneDirectory("Abdul Haq", "5097773796"),
      new Contact.phoneDirectory("Marth Gady", "5097773260"),
      new Contact.phoneDirectory("Kent Jones", "5097773734"),
      new Contact.phoneDirectory("Jude Battista", "5097774778"),
      new Contact.phoneDirectory("Lorelai Hannover", "5097774340"),
      new Contact.phoneDirectory("Steven Zemke", "5097773911"),
      new Contact.phoneDirectory("Adam King", "5097771000"),
      new Contact.phoneDirectory("Denise Cradburry", "5097774444"),
    ];
    return directoryList;
  }
}