import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:horse_management/HMS/Paddock/models/paddock.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String paddockTable = 'paddock_table';
  String colId = 'id';
  String colName = 'name';
  String colMainUse = 'main_use';
  String colLocation = 'location';
  String colArea = 'area';
  String colHasShade = 'has_shade';
  String colHasWater = 'has_water';
  String colGrass = 'grass';
  String colOtherAnimals = 'other_animals';
  String colComments = 'comments';
  String colDate = 'date';





  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'paddock.db';

    // Open/create the database at a given path
    var paddockDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return paddockDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $paddockTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        ' $colMainUse TEXT ,$colLocation INTEGER, $colArea TEXT, $colHasShade INTEGER, $colHasWater INTEGER, $colGrass TEXT, $colOtherAnimals TEXT, $colDate TEXT, $colComments TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getPaddockMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(paddockTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Paddocks paddocks) async {
    Database db = await this.database;
    var result = await db.insert(paddockTable, paddocks.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Paddocks paddocks) async {
    var db = await this.database;
    var result = await db.update(paddockTable, paddocks.toMap(), where: '$colId = ?', whereArgs: [paddocks.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $paddockTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $paddockTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Paddocks>> getPaddockList() async {

    var paddockMapList = await getPaddockMapList(); // Get 'Map List' from database
    int count = paddockMapList.length;         // Count the number of map entries in db table

    List<Paddocks> paddockList = List<Paddocks>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      paddockList.add(Paddocks.fromMapObject(paddockMapList[i]));
    }

    return paddockList;
  }

}