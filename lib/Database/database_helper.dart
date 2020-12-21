import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase5.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';
  static final columnId = 'id';
  static final columnFName = 'fname';
  static final columnLName = 'lname';
  static final columnEmail = 'email';
  static final columnPassword = 'password';
  static final columnIscheck = 'ischeck';
  static final columnLoginwith = 'loginwith';
  static final columnAppId = 'app_id';
  static final columnName = 'name';
  static final columnDOB = 'date_of_birth';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;


  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnAppId TEXT,
            $columnFName TEXT NOT NULL,
            $columnLName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL UNIQUE,
            $columnPassword TEXT,
            $columnIscheck TEXT,
            $columnLoginwith TEXT NOT NULL   
          )
          ''');
  }


  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> selectEmail(String email) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM my_table WHERE email=?',[email]);
  }

  Future<int> updateItem(Map<String, dynamic> row, id) async {
    Database db = await instance.database;
    return await db.update(table, row, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}