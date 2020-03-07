import 'package:horse_management/Model/Add_Note.dart';
import 'package:horse_management/Model/Health_Record.dart';
import 'package:horse_management/Model/Training.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class sqlite_helper{
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }
  initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'HMS.db');
    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Training ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "trainer_name TEXT,"
        "trainer_id  INTEGER,"
        "horse_name TEXT,"
         "horse_id INTEGER"
        "training_center TEXT,"
        "training_type TEXT,"
        "training_type_id INTEGER,"
        "target_competition TEXT,"
        "start_date TEXT,"
        "end_date TEXT,"
        "target_date TEXT,"
        "excercise_plan TEXT,"
         "excercise_plan_id INTEGER"
        ")");
    await db.execute("CREATE TABLE Health_Record ("
       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "horse_name TEXT,"
        "record_type  TEXT,"
        "responsible TEXT,"
        "product TEXT,"
        "quantity INTEGER,"
        "comment TEXT,"
        "amount INTEGER,"
        "currency TEXT,"
        "category TEXT,"
        "cost_center TEXT,"
        "contact TEXT"
        ")");
    await db.execute("CREATE TABLE Add_Note("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "horse_name TEXT,"
        "comment TEXT,"
        "select_date TEXT"
        ")");
  }
  //Health Record
  Future<int> create_health_record(Health_Record health_record) async {
    var dbClient = await db;
    var result = await dbClient.insert("Health_Record", health_record.toMap());
    return result;
  }
  Future<List> get_health_record() async {
    var dbClient= await db;
    var result = await dbClient.rawQuery('SELECT * FROM Health_Record');
    return result.toList();
  }
  Future<int> deleteHeathRecord() async {
    var dbClient= await db;
    return await dbClient.rawDelete('DELETE FROM Health_Record');
  }
  //Training
 Future<int> create_training(Training training) async {
  var dbClient = await db;
   var result = await dbClient.insert("Training", training.toMap());
   return result;
 }
  Future<List> getTraining() async {
    var dbClient= await db;
    var result = await dbClient.rawQuery('SELECT * FROM Training');
    return result.toList();
  }
  Future<int> deleteTraining() async {
    var dbClient= await db;
    return await dbClient.rawDelete('DELETE FROM Training');
  }
  //Add Note

  Future<int> create_add_note(Add_Note add_note) async {
    var dbClient = await db;
    var result = await dbClient.insert("Add_Note", add_note.toMap());
    return result;
  }
  Future<List> get_add_note() async {
    var dbClient= await db;
    var result = await dbClient.rawQuery('SELECT * FROM Add_Note');
    return result.toList();
  }
  Future<int> delete_add_note() async {
    var dbClient= await db;
    return await dbClient.rawDelete('DELETE FROM Add_Note');
  }

}
