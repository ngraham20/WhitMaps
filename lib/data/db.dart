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
      latitude: 47.752613,
      longitude: -117.418946,
      type: "RESIDENCE_HALL",
      name: "Warren Hall",
      poiImage: "assets/poi_images/warren.jpg",
      description: "Warren is a residence hall at Whitworth University. It is composed of three wings: East, South, and West. For East, the first floor is male, and the second and third are female. For South, the basement, first floor, and third floor are female, and the second floor is male. For West, the first and second floors are female, and the third is male."
    ));
    await createPoi(db, Poi( 
      latitude: 47.753273,
      longitude: -117.420151,
      type: "RESIDENCE_HALL",
      name: "Ballard Hall",
      poiImage: "assets/poi_images/ballard.jpg",
      description: "Ballard is an all-female residence hall and houses 65 students. Ballard and McMillan are considered one community in 2 separate buildings and are referred to collectively as BMAC."
    ));
    await createPoi(db, Poi( 
      latitude: 47.754083,
      longitude: -117.419761,
      type: "RESIDENCE_HALL",
      name: "MThe only all-male residence hall on campus, McMillan houses about 75 residents. McMillan, or “Mac” as it’s often called, organized the Mac Hall Haunted House each year. Ballard and McMillan are considered one community in 2 separate buildings and are referred to collectively as BMAC.cMillan Hall",
      poiImage: "assets/poi_images/mac.jpg",
      description: ""
    ));
    await createPoi(db, Poi( 
      latitude: 47.753329,
      longitude: -117.415420,
      type: "RESIDENCE_HALL",
      name: "Arend Hall",
      poiImage: "assets/poi_images/arend.jpg",
      description: "Arend Hall is a residence hall at Whitworth University. The basement and second floor are male, and the first and third floors are female."
    ));
    await createPoi(db, Poi( 
      latitude: 47.753146,
      longitude: -117.413140,
      type: "RESIDENCE_HALL",
      name: "Boppell Hall",
      poiImage: "assets/poi_images/boppell.jpg",
      description: "Boppell Hall is a residence hall at Whitworth University. The first and second floor are all female, and the third floor is male."
    ));
    await createPoi(db, Poi( 
      latitude: 47.753505,
      longitude: -117.416868,
      type: "LIBRARY",
      name: "Library",
      poiImage: "assets/poi_images/library.jpg",
      description: "Whitworth University’s campus library. Students can get personalized help with their research and writing and can find places to study or work on group projects. Home to a Mac lab as well as multiple PC labs and a sheet music library. Whitworth’s writing center, the Whitworth Composition Commons (WCC) is also located upstairs in the library, where students can receive free writing tutoring to become better, more independent writers."
    ));

    await createPoi(db, Poi(
      latitude: 47.754154,
      longitude: -117.418777,
      type: "ACADEMIC",
      name: "Weyerhaeuser Hall",
      poiImage: "assets/poi_images/weyer.jpg",
      description: "Home to the history department and the school of business. The Robinson Teaching Theatre can also be found in Weyerhaeuser (which has an occupancy of 246—by far the largest classroom on campus). The Dornsife Center for Community Engagement is also located in Weyerhaeuser."
    ));
    await createPoi(db, Poi(
      latitude: 47.754097, 
      longitude: -117.415810,
      type: "ACADEMIC",
      name: "Eric Johnson Science Center (EJ)",
      poiImage: "assets/poi_images/ej.jpg",
      description: "One of the two science buildings on campus. Home to the physics, mathematics, computer science, and engineering departments. In Eric Johnston there is also the human performance lab used by exercise physiology students to run strength and conditioning research. EJ also houses computer labs, an observatory, physics and engineering labs, and a greenhouse."
    ));
    await createPoi(db, Poi( 
      latitude: 47.752662,
      longitude: -117.415399,
      type: "HUB",
      name: "Hixun Union Building (HUB)",
      poiImage: "assets/poi_images/hub.jpg",
      description: "The HUB is the unofficial social center of Whitworth’s campus. On the first floor of the HUB are the university bookstore, the dining hall, the post office, and the Mind and Hearth coffee shop. On the second floor are Career Services, Office for eductaional support services, the media hall, Student Life, and ASWU (Associated Students of Whitworth University)."
    ));
    await createPoi(db, Poi(
      latitude: 47.754248,
      longitude: -117.416862,
      type: "ACADEMIC",
      name: "Robinson Science Building",
      poiImage: "assets/poi_images/robinson.jpg",
      description: "One of the two science buildings on campus. Home to the biology, chemistry, health science, and bio-chemistry departments. Professor’s offices are all along the central wall which creates a space for a relationship outside the classroom. On the 3rd floor of the building there is a 400 megahertz Nuclear Magnetic Resonance Spectrometer. It is the highest field magnet in the Spokane-region. It is used in splitting chemicals to determine chemical structures. Robinson also houses the Anatomy and Physiology lab, as well as the Vivarium (live animal lab)."
    ));

    await createPoi(db, Poi( 
      latitude: 47.755250,
      longitude: -117.420925,
      type: "ACADEMIC",
      name: "Aquatics Center & Scotford Strength Center",
      poiImage: "assets/poi_images/aquatic.jpg",
      description: "Here are located Whitworth’s main pool as well as a small weight training gym, respectively."
    ));

    await createPoi(db, Poi( 
      latitude: 47.754258,
      longitude: -117.417108,
      type: "ACADEMIC",
      name: "Lied Center for the Visual Arts",
      poiImage: "assets/poi_images/art.jpg",
      description: "The art department is located in the Lied Center for the Visual Arts, as well as an art gallery that showcases student and professional artwork, a Mac lab, and resources for mixed media and ceramics."
    ));

    await createPoi(db, Poi(
      latitude: 47.750431,
      longitude: -117.414951,
      type: "HOUSE",
      name: "President's House",
      poiImage: "assets/poi_images/pres.jpg",
      description: "This is the house of Whitworth University’s president and his family. It is located on the corner of Hawthorne Road and Whitworth Drive."
    ));

    await createPoi(db, Poi(
      latitude: 47.750945,
      longitude: -117.419478,
      type: "HOUSE",
      name: "Auld House",
      poiImage: "assets/poi_images/auld.jpg",
      description: "Home of Whitworth’s human resources services."
    ));

    await createPoi(db, Poi( 
      latitude: 47.754787,
      longitude: -117.415080,
      type: "RESIDENCE_HALL",
      name: "Baldwin Jenkins Hall",
      poiImage: "assets/poi_images/bj.jpg",
      description: "Baldwin Jenkins Hall is a residence hall at Whitworth University. The first floor is male and the second floor is female."
    ));

    await createPoi(db, Poi( 
      latitude: 47.753193,
      longitude: -117.419480,
      type: "CHAPEL",
      name: "Beeksma Family Theology Center",
      poiImage: "assets/poi_images/chapel.jpg",
      description: "The theology department is housed here as well as campus ministry and the Office of Church Engagement. Chapel is held twice a week here on Tuesdays and Thursdays from 11:00am to 11:30am; no classes are scheduled at this time."
    ));

    await createPoi(db, Poi( 
      latitude: 47.752143,
      longitude: -117.418237,
      type: "ACADEMIC",
      name: "Dixon Hall",
      poiImage: "assets/poi_images/dixon.jpg",
      description: "Home to the Education and Psychology departments. A variety of class types are held in Dixon’s classrooms."
    ));

    await createPoi(db, Poi(
      latitude: 47.753662,
      longitude: -117.412399,
      type: "RESIDENCE_HALL",
      name: "Duvall Hall",
      poiImage: "assets/poi_images/duvall.jpg",
      description: "Duvall Hall is a residence hall at Whitworth University. The first and fourth floors are male, and the second and third floors are female."
    ));

    await createPoi(db, Poi( 
      latitude: 47.751737,
      longitude: -117.417399,
      type: "ACADEMIC",
      name: "McEachran Hall",
      poiImage: "assets/poi_images/financial.jpg",
      description: "Home to Registrars, Financial Aid, President’s Office, Business Office, and Student Accounts. Switching classes, paying tuition bills, getting your paycheck, and speaking with your financial aid counselor are just some of the many things you can do in McEachran."
    ));

    await createPoi(db, Poi( 
      latitude: 47.753771,
      longitude: -117.420886,
      type: "ACADEMIC",
      name: "Graves Gym",
      poiImage: "assets/poi_images/graves.jpg",
      description: "Whitworth’s original gym, now used primarily to house coaches’ offices."
    ));

    await createPoi(db, Poi(
      latitude: 47.754809,
      longitude: -117.421823,
      type: "SPORTS",
      name: "Fieldhouse",
      poiImage: "assets/poi_images/fieldhouse.jpg",
      description: "Here in the fieldhouse is Whitworth’s main basketball court, as well as a dance loft upstairs."
    ));

    await createPoi(db, Poi( 
      latitude: 47.751283,
      longitude: -117.413895,
      type: "HOUSE",
      name: "Hardwick House",
      poiImage: "assets/poi_images/hardwick.jpg",
      description: "Whitworth’s office of alumni and parent relations is located here."
    ));

    await createPoi(db, Poi( 
      latitude: 47.754505,
      longitude: -117.418049,
      type: "HEALTH",
      name: "Schumacher Hall",
      poiImage: "assets/poi_images/health.jpg",
      description: "Schumacher Hall is home to Whitworth’s health center as well as their counseling center, both of which are services offered to all Whitworth students."
    ));

    await createPoi(db, Poi( 
      latitude: 47.753795,
      longitude: -117.415189,
      type: "ACADEMIC",
      name: "Hendrick Hall",
      poiImage: "assets/poi_images/hendrick.jpg",
      description: "Houses the Office for Diversity, Equity, and Inclusion (which includes international admission, study abroad programs, and the Intercultural Student Center)."
    ));

    await createPoi(db, Poi( 
      latitude: 47.753664,
      longitude: -117.418035,
      type: "ACADEMIC",
      name: "Lindaman Center",
      poiImage: "assets/poi_images/lindaman.jpg",
      description: "Home to the communications, philosophy, political science, and sociology departments. There are no classrooms in Lindaman; it is only offices and departments. In Lindaman, there is also the Student Success Center, where students can go to receive academic resources and strategies, such as time management techniques and study strategies, as well as one-on-one student success coaching."
    ));

    await createPoi(db, Poi(
      latitude: 47.750969,
      longitude: -117.417105 ,
      type: "HOUSE",
      name: "MacKay Hall",
      poiImage: "assets/poi_images/mackay.jpg",
      description: "MacKay Hall is where Whitworth’s Admissions Office is located. It is directly across Hawthorne Road from Cowles Auditorium."
    ));

    await createPoi(db, Poi( 
      latitude: 47.751737,
      longitude: -117.419041,
      type: "ACADEMIC",
      name: "Cowles Music Center",
      poiImage: "assets/poi_images/music_building.jpg",
      description: "Home of the music department, rehearsal rooms, practice rooms, a central recording room, and the 110-seat Myhre Recital Hall."
    ));

    await createPoi(db, Poi(
      latitude: 47.754417,
      longitude: -117.412804,
      type: "RESIDENCE_HALL",
      name: "Oliver Hall",
      poiImage: "assets/poi_images/oliver.jpg",
      description: "Oliver Hall is a residence hall at Whitworth University. The basement and first floor are male, and the second and third floors are female."
    ));

    await createPoi(db, Poi(
      latitude: 47.754042,
      longitude: -117.414236,
      type: "RESIDENCE_HALL",
      name: "Stewart Hall",
      poiImage: "assets/poi_images/stewart.jpg",
      description: "Stewart Hall is a residence hall at Whitworth University. The second floor is male and the third is female."
    ));

    await createPoi(db, Poi( 
      latitude: 47.755769,
      longitude: -117.420705,
      type: "SPORTS",
      name: "Scotford Tennis Center",
      poiImage: "assets/poi_images/tennis_court_outdoor.jpg"
    ));

    await createPoi(db, Poi( 
      latitude: 47.751730,
      longitude: -117.418032,
      type: "ACADEMIC",
      name: "Cowles Auditorium",
      poiImage: "assets/poi_images/theater.jpg",
      description: "Home to the theatre department. There are two main stage productions each year, a musical every other year, held in the auditorium. Lectures, concerts, Bingo, and orientation activities also take place in the auditorium."
    ));

    await createPoi(db, Poi( 
      latitude: 47.755654,
      longitude: -117.419242,
      type: "SPORTS",
      name: "U-REC",
      poiImage: "assets/poi_images/urec.jpg",
      description: "The university’s gym and recreational center. Home to an indoor track, 3 basketball courts (not full length), full cardio and weight equipment, and a rock climbing wall. Whitworth Outdoors is also located in the UREC."
    ));

    await createPoi(db, Poi(
      latitude: 47.754291,
      longitude: -117.413817,
      type: "RESIDENCE_HALL",
      name: "The Village",
      poiImage: "assets/poi_images/village.jpg",
      description: "The Village is a group of 3 small residence halls behind Stewart Hall: namely, Tiki, Shalom, and Akili. Tiki’s first floor is female and its second is male. Shalom’s first floor is male and the second is female. Akili’s first and second floors are both female."
    ));

await createPoi(db, Poi( 
      latitude: 47.754969,
      longitude: -117.419422,
      type: "ACADEMIC",
      name: "Westminster Hall",
      poiImage: "assets/poi_images/westminster.jpg",
      description: "The English department, World Languages department, and Kinesiology department are all located in Westminster."
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