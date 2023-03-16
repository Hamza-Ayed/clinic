import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DBSqlFF {
  static Database? _db;
  final String table;

  DBSqlFF(this.table);

  Future<Database> get db async {
    _db ??= await initialDB();
    return _db!;
  }

  Future<Database> initialDB() async {
    final docDirect = await getApplicationDocumentsDirectory();
    final path = join(docDirect.path, 'sqfff.db');
    final databaseFactory = databaseFactoryFfi;
    final db = await databaseFactory.openDatabase(path);
    await _onCreate(db, 1);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createUsersTable(db);
    await _createPatientsTable(db);
    await _createChecksHealthTable(db);
    await _createDrugsTable(db);
    await _createSalaryTable(db);
    await _createDeviceTable(db);
    await _createClinicExpensesTable(db);
  }

  Future<void> _createUsersTable(Database db) async {
    await db.execute('CREATE TABLE Users ('
        'id INTEGER PRIMARY KEY,'
        'username TEXT UNIQUE ,'
        'password TEXT ,'
        'doctorId TEXT ,'
        'devicename TEXT '
        ')');
    print('Users Table Created');
  }

  Future<void> _createPatientsTable(Database db) async {
    await db.execute('CREATE TABLE Patients ('
        'id INTEGER PRIMARY KEY,'
        'patintName TEXT,'
        'birhdate INTEGER,'
        'gender TEXT,'
        'site TEXT,'
        'phone TEXT,'
        'lastVisit TEXT'
        ')');
    print('Patients Table Created');
  }

  Future<void> _createChecksHealthTable(Database db) async {
    await db.execute(
      'CREATE TABLE ChecksHealth ('
      'id INTEGER PRIMARY KEY,'
      'tesChecksHealthtName       TEXT '
      ')',
    );
    print('ChecksHealth Table Created');
  }

  Future<void> _createDrugsTable(Database db) async {
    await db.execute(
      'CREATE TABLE Drugs ('
      'id INTEGER PRIMARY KEY,'
      'subject_name       TEXT ,'
      'barcode             TEXT'
      ')',
    );
    print('Drugs Table Created');
  }

  Future<void> _createSalaryTable(Database db) async {
    await db.execute(
      'CREATE TABLE salary ('
      'salary_id                INTEGER PRIMARY KEY,'
      'Secretary_id             TEXT ,'
      'doctor_id                TEXT,'
      'salary                   TEXT,'
      'salary_pluse             TEXT,'
      'salary_minus             TEXT'
      ')',
    );
    print('Salary Table Created');
  }

  Future<void> _createDeviceTable(Database db) async {
    await db.execute(
      'CREATE TABLE Device ('
      'id                INTEGER PRIMARY KEY,'
      'deviceID             TEXT UNIQUE'
      ')',
    );
    print('Device Table Created');
  }

  Future<void> _createClinicExpensesTable(Database db) async {
    await db.execute(
      'CREATE TABLE ClinicExpenses ('
      'id                INTEGER PRIMARY KEY,'
      'salary             TEXT ,'
      'electric                TEXT,'
      'Visiting                   TEXT,'
      'ClinikRental             TEXT,'
      'water             TEXT,'
      'gas             TEXT,'
      'paper             TEXT,'
      'medicalsupplies             TEXT,'
      'doctorId             TEXT'
      ')',
    );
    print('Clinic Expenses Table Created');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    final dbClient = await db;
    return dbClient.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final dbClient = await db;
    return dbClient.query(table, distinct: true);
  }

  Future<List<Map<String, dynamic>>> getDataQuery(
      String table, deviceId) async {
    final dbClient = await db;
    return dbClient.query(table, where: 'deviceID = ?', whereArgs: [deviceId]);
  }

  Future<int> deleteAll(String table) async {
    final dbClient = await db;
    return dbClient.delete(table);
  }

  Future<int> delete(String table, id) async {
    var dbClient = await db;

    var deletednote =
        await dbClient.rawDelete('DELETE FROM $table Where id=$id');

    return deletednote;
  }

  Future<int> deleteUser(String table, deviceID) async {
    var dbClient = await db;

    var deletednote = await dbClient
        .rawDelete('DELETE FROM $table Where devicename=$deviceID');

    return deletednote;
  }
}
