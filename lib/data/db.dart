import 'package:sqflite/sqflite.dart';
import 'package:whitmaps/model/contact.dart';

createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = databasesPath + 'my.db';

  var database = await openDatabase(dbPath, version: 1, onCreate: initDB);
  return database;
  }

void initDB(Database db, int version) async {
  await db.execute("CREATE TABLE Customer ("
        "id INTEGER PRIMARY KEY,"
        "first_name TEXT,"
        "last_name TEXT,"
        "email TEXT"
        ")");
}

Future<int> createContact(Database db, Contact contact) async {
  var result = await db.insert("Contact", contact.toMap());
  return result;
}

Future<List> getContacts(Database db) async {
  var result = await db.query("Contact", columns:
  ["name", "primary_phone", 
  "home_phone", "mobile_phone", "office_phone"]);
  return result.toList();
}

Future<Contact> getContact(Database db, String name) async {
  List<Map> results = await db.query("Contact",
    columns: ["name", "primary_phone", "home_phone", "mobile_phone", "office_phone"],
    where: 'name = ?',
    whereArgs: [name]);

  if (results.length > 0) {
    return new Contact.fromJson(results.first);
  }

  return null;
}

Future<int> updateContact(Database db, Contact contact) async {
  return await db.update("Contact",
    contact.toMap(),
    where: 'name = ? and primary_phone = ?',
    whereArgs: [contact.name, contact.primaryPhone]);
}

Future<int> deleteContact(Database db, Contact contact) async {
  return await db.delete("Contact",
  where: 'name = ? and primary_phone = ?',
  whereArgs: [contact.name, contact.primaryPhone]
  );
}

void closeDatabase(Database db) async {
  await db.close();
}