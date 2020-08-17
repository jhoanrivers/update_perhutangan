

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:updateperutangan/src/model/account.dart';

class DbClient {

  static DbClient _dbClient;
  static Database _database;


  DbClient._createObject();

  factory DbClient(){
    if(_dbClient == null){
      _dbClient = DbClient._createObject();
    }
    return _dbClient;
  }



  Future<Database> initDb() async {


    // nama dan lokasi database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'user.db';

    // create, read database
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return todoDatabase;

  }


  void _createDb(Database database, int version) async{

    await database.execute('''
      CREATE TABLE user(
        id_user INTEGER,
        name TEXT,
        username TEXT,
        fcm_token TEXT,
        gopay TEXT,
        gopay_name TEXT,
        ovo TEXT,
        ovo_name TEXT
      )
      
      ''');


  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initDb();
    }
    return _database;
  }



  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('user', orderBy: 'userId');
    return mapList;
  }


  // insert data to database
  Future<int> insert (Account account) async{
    Database database = await this.database;
    int count = await database.insert('user', account.toMap());
    return count;
  }

  // delete database

  Future<int> delete(int id) async {
    Database database = await this.database;
    int count = await database.delete('account',
        where: 'user_id=?',
        whereArgs: [id]);

    return count;
  }







}