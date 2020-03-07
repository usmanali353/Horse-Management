import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/models/breedingControl.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String breedingControlTable = 'breeding_control_table';
  String colId = 'id';
  String colHorseName = 'horse_name';
  String colDate = 'date';
  String colHours = 'hours';
  String colCheckMethod = 'check_method';
  String colVet = 'vet';
  String colRelatedServices = 'related_services';
  String colEmpty = 'empty';
  String colPregnancy = 'pregnancy';
  String colAbortion = 'abortion';
  String colReabsorption = 'reabsorption';
  String colFollicle = 'follicle';
  String colOvule = 'ovule';
  String colTwins = 'twins';
  String colVolvoplasty = 'volvoplasty';


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
    String path = directory.path + 'breedingControl.db';

    // Open/create the database at a given path
    var horseDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return horseDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $breedingControlTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colHorseName TEXT, '
        '$colDate TEXT, $colHours TEXT, $colCheckMethod TEXT, $colVet TEXT, , $colRelatedServices TEXT, $colEmpty TEXT, $colPregnancy TEXT, $colAbortion TEXT,$colReabsorption TEXT,$colFollicle TEXT,$colOvule TEXT,$colTwins TEXT, $colVolvoplasty TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getBreedingControlMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(breedingControlTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(BreedingControl breedingControl) async {
    Database db = await this.database;
    var result = await db.insert(breedingControlTable, breedingControl.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(BreedingControl breedingControl) async {
    var db = await this.database;
    var result = await db.update(breedingControlTable, breedingControl.toMap(), where: '$colId = ?', whereArgs: [breedingControl.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $breedingControlTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $breedingControlTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<BreedingControl>> getBreedingControlList() async {

    var horseMapList = await getBreedingControlMapList(); // Get 'Map List' from database
    int count = horseMapList.length;         // Count the number of map entries in db table

    List<BreedingControl> horseList = List<BreedingControl>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      horseList.add(BreedingControl.fromMapObject(horseMapList[i]));
    }

    return horseList;
  }

}