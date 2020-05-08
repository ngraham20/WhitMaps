import 'package:sqflite/sqflite.dart';
import 'package:whitmaps/models/contact.dart';
import 'package:whitmaps/models/poi.dart';


class DB {
  static createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = databasesPath + 'whitmaps.db';

    var database = await openDatabase(dbPath, version: 1, onCreate: initDB);
    return database;
    }

  static void initDB(Database db, int version) async {
    await db.execute("CREATE TABLE Contact ("
          "name TEXT PRIMARY KEY,"
          "primary_phone TEXT PRIMARY KEY,"
          "home_phone TEXT,"
          "office_phone TEXT"
          "mobiel_phone TEXT"
          ")"
          
          "CREATE TABLE Poi ("
          "latitude INTEGER PRIMARY KEY"
          "longitude INTEGER PRIMARY KEY"
          "name TEXT"
          "description TEXT"
          "poi_image TEXT"
          "type TEXT"
          ")");
  }

  //-----------------------------------------------------------
  //                       CONTACT
  //-----------------------------------------------------------

  static Future<int> createContact(Database db, Contact contact) async {
    var result = await db.insert("Contact", contact.toMap());
    return result;
  }

  static Future<List> getContacts(Database db) async {
    var result = await db.query("Contact", columns:
    ["name", "primary_phone", 
    "home_phone", "mobile_phone", "office_phone"]);
    return result.toList();
  }

  static Future<Contact> getContact(Database db, String name) async {
    List<Map> results = await db.query("Contact",
      columns: ["name", "primary_phone", "home_phone", "mobile_phone", "office_phone"],
      where: 'name = ?',
      whereArgs: [name]);

    if (results.length > 0) {
      return new Contact.fromJson(results.first);
    }

    return null;
  }

  static Future<int> updateContact(Database db, Contact contact) async {
    return await db.update("Contact",
      contact.toMap(),
      where: 'name = ? and primary_phone = ?',
      whereArgs: [contact.name, contact.primaryPhone]);
  }

  static Future<int> deleteContact(Database db, Contact contact) async {
    return await db.delete("Contact",
    where: 'name = ? and primary_phone = ?',
    whereArgs: [contact.name, contact.primaryPhone]
    );
  }

  //-----------------------------------------------------------
  //                          POI
  //-----------------------------------------------------------

  static Future<int> createPoi(Database db, Poi poi) async {
    var result = await db.insert("Contact", poi.toMap());
    return result;
  }

  static Future<List> getPoi(Database db) async {
    var result = await db.query("Poi", columns:
    ["latitude", "longitude", "name",
    "description", "poi_image",
    "type"]);
    return result.toList();
  }

  static Future<int> updatePoi(Database db, Poi poi) async {
    return await db.update("Contact",
      poi.toMap(),
      where: 'latitude = ? and longitude = ?',
      whereArgs: [poi.latitude, poi.longitude]);
  }

  static Future<int> deletePoi(Database db, Poi poi) async {
    return await db.delete("Contact",
    where: 'latitude = ? and longitude = ?',
    whereArgs: [poi.latitude, poi.longitude]
    );
  }

  static void closeDatabase(Database db) async {
    await db.close();
  }
}