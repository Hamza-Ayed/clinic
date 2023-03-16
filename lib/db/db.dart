import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBSql {
  static Database? _db;
  final String table;

  DBSql(this.table);

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();

      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory docDirect = await getApplicationDocumentsDirectory();
    String path = join(docDirect.path, 'checks.db');
    var mydb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Users ('
        'id INTEGER PRIMARY KEY,'
        'username    TEXT   UNIQUE ,'
        'password      TEXT ,'
        'doctorId      TEXT ,'
        'devicename       TEXT  '
        ')');
    print('Users Table Created');

    // await db.execute(
    //   'CREATE TABLE ChecksHealth ('
    //   'id INTEGER PRIMARY KEY,'
    //   'testName       TEXT '
    //   ')',
    // );
    // print('ChexksHealth Table Created');

    // await db.execute(
    //   'CREATE TABLE Drugs ('
    //   'id INTEGER PRIMARY KEY,'
    //   'subject_name       TEXT ,'
    //   'barcode             TEXT'
    //   ')',
    // );
    // print('drugs Table Created');
    // await db.execute(
    //   'CREATE TABLE salary ('
    //   'salary_id                INTEGER PRIMARY KEY,'
    //   'Secretary_id             TEXT ,'
    //   'doctor_id                TEXT,'
    //   'salary                   TEXT,'
    //   'salary_pluse             TEXT,'
    //   'salary_minus             TEXT'
    //   ')',
    // );
    // print('salary Table Created');

    // await db.execute(
    //   'CREATE TABLE Device ('
    //   'id                INTEGER PRIMARY KEY,'
    //   'deviceID             TEXT UNIQUE'
    //   ')',
    // );
    // print('Device Table Created');

    // await db.execute(
    //   'CREATE TABLE ClinicExpenses ('
    //   'id                INTEGER PRIMARY KEY,'
    //   'salary             TEXT ,'
    //   'electric                TEXT,'
    //   'Visiting                   TEXT,'
    //   'ClinikRental             TEXT,'
    //   'water             TEXT,'
    //   'gas             TEXT,'
    //   'paper             TEXT,'
    //   'medicalsupplies             TEXT,'
    //   'doctorId             TEXT'
    //   ')',
    // );
    // print('Clinic expenses Table Created');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    initialDB();
    var dbClient = await db;

    var insert = dbClient!.insert(table, data);

    return insert;
  }

  Future<List> getData(String table) async {
    var dbClinte = await db;
    var newsDistinct = await dbClinte!.rawQuery(
      // 'SELECT  title,imageurl,content,link,pubdate FROM $teamName ORDER BY pubdate DESC',
      'SELECT DISTINCT * FROM $table ',
    );
    return newsDistinct;
  }

  Future<List> getDataQuery(String table, deviceId) async {
    var dbClinte = await db;
    var newsDistinct = await dbClinte!.rawQuery(
      // 'SELECT  title,imageurl,content,link,pubdate FROM $teamName ORDER BY pubdate DESC',
      'SELECT  * FROM $table Where deviceID =$deviceId',
    );
    return newsDistinct;
  }

  Future<int> deleteAll(String table) async {
    var dbClient = await db;

    var deletednote = await dbClient!.rawDelete('DELETE FROM $table ');

    return deletednote;
  }

  Future<int> delete(String table, id) async {
    var dbClient = await db;

    var deletednote =
        await dbClient!.rawDelete('DELETE FROM $table Where id=$id');

    return deletednote;
  }

  Future<int> deleteUser(String table, deviceID) async {
    var dbClient = await db;

    var deletednote = await dbClient!
        .rawDelete('DELETE FROM $table Where devicename=$deviceID');

    return deletednote;
  }
}
