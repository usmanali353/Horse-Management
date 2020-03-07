import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:horse_management/HMS/HorseGroups/models/group.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String horseTable = 'horse_table';
  String colId = 'id';
  String colName = 'name';
  String colComments = 'comments';
  String colDynamics = 'dynamics';
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
    String path = directory.path + 'horse.db';

    // Open/create the database at a given path
    var horseDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return horseDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $horseTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colComments TEXT, $colDynamics INTEGER, $colDate TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getHorseMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(horseTable, orderBy: '$colDynamics');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Groups groups) async {
    Database db = await this.database;
    var result = await db.insert(horseTable, groups.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Groups groups) async {
    var db = await this.database;
    var result = await db.update(horseTable, groups.toMap(), where: '$colId = ?', whereArgs: [groups.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $horseTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $horseTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Groups>> getHorseList() async {

    var horseMapList = await getHorseMapList(); // Get 'Map List' from database
    int count = horseMapList.length;         // Count the number of map entries in db table

    List<Groups> horseList = List<Groups>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      horseList.add(Groups.fromMapObject(horseMapList[i]));
    }

    return horseList;
  }

}