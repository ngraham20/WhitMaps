import 'package:sqflite/sqflite.dart';
import 'package:whitmaps/models/contact.dart';
import 'package:whitmaps/models/poi.dart';


class DB {

  bool initialized = false;
  Database database;

  static Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = databasesPath + 'whitmaps.db';

    var database = await openDatabase(dbPath, version: 1, onCreate: initDB);
    return database;
    }

  static void initDB(Database db, int version) async {
    await db.execute("CREATE TABLE contact ("
          "name TEXT,"
          "primary_phone TEXT PRIMARY KEY,"
          "home_phone TEXT,"
          "office_phone TEXT,"
          "mobile_phone TEXT"
          ");");
    await db.execute("CREATE TABLE poi ("
          "latitude INTEGER,"
          "longitude INTEGER,"
          "name TEXT,"
          "description TEXT,"
          "poi_image TEXT,"
          "type TEXT,"
          "primary key (latitude, longitude)"
          ");");

    await DB.createDefaultPois(db);
  }
  //-----------------------------------------------------------
  //                       CONTACT
  //-----------------------------------------------------------

  static Future<int> createContact(Database db, Contact contact) async {
    var result = await db.insert("Contact", contact.toMap());
    return result;
  }

  static Future<List> getContacts(Database db) async {
    var result = await db.query("contact", columns:
    ["name", "primary_phone", 
    "home_phone", "mobile_phone", "office_phone"]);
    return result.toList();
  }

  static Future<Contact> getContact(Database db, String name) async {
    List<Map> results = await db.query("contact",
      columns: ["name", "primary_phone", "home_phone", "mobile_phone", "office_phone"],
      where: 'name = ?',
      whereArgs: [name]);

    if (results.length > 0) {
      return new Contact.fromJson(results.first);
    }

    return null;
  }

  static Future<int> updateContact(Database db, Contact contact) async {
    return await db.update("contact",
      contact.toMap(),
      where: 'name = ? and primary_phone = ?',
      whereArgs: [contact.name, contact.primaryPhone]);
  }

  static Future<int> deleteContact(Database db, Contact contact) async {
    return await db.delete("contact",
    where: 'name = ? and primary_phone = ?',
    whereArgs: [contact.name, contact.primaryPhone]
    );
  }

  //-----------------------------------------------------------
  //                          POI
  //-----------------------------------------------------------

  static Future<int> createPoi(Database db, Poi poi) async {
    var result = await db.insert("poi", poi.toMap());
    return result;
  }

  static createDefaultPois(Database db) async {
    await createPoi(db, Poi(
      latitude: 47.752750,
      longitude: -117.41894,
      type: "RESIDENCE_HALL",
      name: "Warren Hall"
    ));
    await createPoi(db, Poi(
      latitude: 47.753503,
      longitude: -117.41894,
      type: "RESIDENCE_HALL",
      name: "Ballard Hall"
    ));
    await createPoi(db, Poi(
      latitude: 47.754025,
      longitude: -117.41977,
      type: "RESIDENCE_HALL",
      name: "MacMillan Hall"
    ));
    await createPoi(db, Poi(
      latitude: 47.753602,
      longitude: -117.415455,
      type: "RESIDENCE_HALL",
      name: "Arend Hall"
    ));
    await createPoi(db, Poi(
      latitude: 47.753182,
      longitude: -117.413183,
      type: "RESIDENCE_HALL",
      name: "Boppell Hall"
    ));
    await createPoi(db, Poi(
      latitude: 47.753490,
      longitude: -117.41692,
      type: "LIBRARY",
      name: "Library"
    ));
    await createPoi(db, Poi(
      latitude: 47.751880, 
      longitude: -117.41546,
      type: "CHURCH",
      name: "Whitworth Church"
    ));
    await createPoi(db, Poi(
      latitude: 47.754132,
      longitude: -117.418627,
      type: "ACADEMIC",
      name: "Weyerhaeuser"
    ));
    await createPoi(db, Poi(
      latitude: 47.754111, 
      longitude: -117.415767,
      type: "ACADEMIC",
      name: "Eric Johnson Science Center (EJ)"
    ));
    await createPoi(db, Poi(
      latitude: 7.752749,
      longitude: 117.41523,
      type: "HUB",
      name: "Hixun Union Building (HUB)"
    ));
    await createPoi(db, Poi(
      latitude: 47.754429,
      longitude: -117.416370,
      type: "ACADEMIC",
      name: "Robinson Science Building"
    ));
  }

  static Future<List> getAllPois(Database db) async {
    var result = await db.query("poi", columns:
    ["latitude", "longitude", "name",
    "description", "poi_image",
    "type"]);
    return result.toList();
  }

  static Future<int> updatePoi(Database db, Poi poi) async {
    return await db.update("poi",
      poi.toMap(),
      where: 'latitude = ? and longitude = ?',
      whereArgs: [poi.latitude, poi.longitude]);
  }

  static Future<int> deletePoi(Database db, Poi poi) async {
    return await db.delete("poi",
    where: 'latitude = ? and longitude = ?',
    whereArgs: [poi.latitude, poi.longitude]
    );
  }

  static void closeDatabase(Database db) async {
    await db.close();
  }
}