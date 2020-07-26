//
//
//import 'dart:convert';
//import 'dart:io';
//
//import 'package:path_provider/path_provider.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:updateperutangan/src/model/account.dart';
//
//class DbClient {
//
//  static DbClient _dbClient;
//  static Database _database;
//
//
//
//
//  static var id;
//  static const name = 'name';
//  static const userName = 'userName';
//  static const gopay = 'goapy';
//  static const gopayName = 'gopay_name';
//  static const ovo ='ovo';
//  static const ovoName = 'ovo_name';
//
//
//  DbClient._createObject();
//
//
//  factory DbClient() {
//    if(_dbClient == null){
//      _dbClient = DbClient._createObject();
//    }
//    return _dbClient;
//  }
//
//
//  Future<Database> initDb() async {
//
//    Directory directory = await getApplicationDocumentsDirectory();
//    String path = directory.path +"account.db";
//
//    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
//    return todoDatabase;
//
//  }
//
//
//  void _createDb (Database db, int version) async {
//    await db.execute(
//      '''CREATE TABLE account (
//        $id INTEGER PRIMARY KEY AUTOINCREMENT,
//        $name TEXT,
//        $userName TEXT,
//        $gopayName TEXT,
//        $gopay TEXT,
//        $ovo TEXT,
//        $ovoName TEXT
//
//      )'''
//    );
//
//  }
//
//
//  Future<Database> get database async{
//    if(_database == null){
//      _database = await initDb();
//
//    }
//  }
//
//  Future<void> insert (Account account) async{
//    Database db = await this.database;
//    db.insert('account', account.toJson());
//
//  }
//
//  Future<Account> getUser (String username) async {
//    Database db = await this.database;
//    Account account;
//    var res = await db.query('account', where: '$username = ? ', whereArgs: [username]);
//
//    if(res.isNotEmpty){
//      var firstAcc = res.first;
//      account= Account.fromJson(firstAcc);
//    }
//    return account;
//
//  }
//
//
//  Future<int> deleteDatabase() async {
//    Database db = await this.database;
//    return await db.delete('account');
//  }
//
//
//}