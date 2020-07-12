import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class DBClient {
  static final _databaseName = 'updateperhutangan.db';
  static final _databaseVersion = 1;
  static final tableUser = 'table_user';

//  User Table

  static final columnId = 'idLocal';
  static final columnUsername = 'username';
  static final columnName = 'name';
  static final columnFcmToken = 'token';
  static final columnOvo = 'ovo';
  static final columnOvoName = 'ovo_name';
  static final columnGopay = 'gopay';
  static final columnGopayName = 'gopay_name';

  DBClient._privateConstructor();

  static final DBClient instance = DBClient._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''CREATE TABLE $tableUser (
       $columnId STRING PRIMARY KEY,
       $columnUsername STRING,




     )''');
  }
}
