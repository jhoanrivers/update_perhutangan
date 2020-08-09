

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:updateperutangan/src/model/account.dart';

class DbClient {

  static final _databaseName = 'updateperhutangan.db';
  static final _databaseVersion = 1;
  static final tableNotification = "table_notification";
  static final tableUser = "table_user";



  // Column on Notification table

  static final columnId = 'idNotification';
  static final columnIdNotification = 'id_item';
  static final columnLender = 'lender';
  static final columnBorrower = 'borrower';
  static final columnStatusLoan = 'status_loan';
  static final columnItem = 'item';
  static final columnDescription= 'description';
  static final columnAmount = "amount";
  static final columnCreated = 'created';
  static final columnUsername = 'username';
  static final columnName = 'name';
  static final columnGopay = 'gopay';
  static final columnGopayName = 'gopay_name';
  static final columnOvo = 'ovo';
  static final columnOvoName = 'ovo_name';



  //Table on User tabel
  static final columnIdForUser = 'id_table';
  static final columnIdUser = 'id_user';
  static final columnUsernameUser = 'username';
  static final columnNameUser = 'name';
  static final columnOvoNameUser = 'ovo_name';
  static final columnOvoUser = 'ovo';
  static final columnGopayNameUser = 'gopay_name';
  static final columnGopayUser = 'gopay';
  static final columnFcmTokenUser = 'fcm_token';



  DbClient._pricateConstructor();

  static final DbClient instance = DbClient._pricateConstructor();

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }


  initDatabase() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);

    return await openDatabase(path,
      version: _databaseVersion,
      onCreate: _onCreate
    );


  }


  Future _onCreate (Database db, int version) async {
    await db.execute('''CREATE TABLE $tableNotification
      ($columnId INTEGER PRIMARY KEY,
       $columnIdNotification INTEGER,
       $columnLender INTEGER,
       $columnBorrower INTEGER,
       $columnStatusLoan TEXT,
       $columnItem TEXT,
       $columnDescription TEXT,
       $columnAmount INTEGER,
       $columnCreated TEXT,
       $columnUsername TEXT,
       $columnName TEXT,
       $columnGopay TEXT,
       $columnGopayName TEXT,
       $columnOvo TEXT,
       $columnOvoName TEXT)''');


    await db.execute(''' CREATE TABLE $tableUser
      ($columnIdForUser INTEGER AUTO INCREMENT,
      $columnIdUser INTEGER,
      $columnUsernameUser TEXT,
      $columnNameUser TEXT,
      $columnOvoNameUser TEXT,
      $columnOvoUser TEXT,
      $columnGopayNameUser TEXT,
      $columnGopayUser TEXT,
      $columnFcmTokenUser TEXT)
      ''');


  }


  Future<void> insertUserToDatabase (Map<String, dynamic> dataMap) async {
    Database db = await this.database;
    db.insert(tableUser, dataMap);
    print(dataMap);
  }


  Future<Account> getUserBySessionUser () async {
    Database db = await this.database;
    
    var res = await db.query(tableUser);

    var jsonData = json.encode(res.first);
    print(jsonData);
    Map dataMap = json.decode(jsonData);
    Account account = Account.fromJson(dataMap);
    
  }










}