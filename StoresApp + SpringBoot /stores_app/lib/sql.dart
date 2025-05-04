import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    // Of course, we cannot create the database more than once; it is only created once.
    // So, If the database has not been created for the first time, we create it then return it. Otherwise, we simply return it.
    // ignore: prefer_conditional_assignment
    if (_db == null) {
      _db = await initialDb();
    }

    return _db;
  }

  initialDb() async {
    // getDatabasesPath() --> is used to determine the path "location" where the data will be stored in Mobile.
    String databasePath = await getDatabasesPath();
    // all path = databasePath/databaseName
    String allPath = join(databasePath, 'marawan.db'); // folder/game/z.db
    // to initialize the database
    Database myDb = await openDatabase(
      allPath,
      // onCreate --> need a function to create the database
      onCreate: _onCreate,
      version: 1,

      // As we know, the database is created only once, meaning the onCreate method runs only once.
      // The onCreate method will be called only once, when the database is created for the first time.
      // It will not be called again unless the database is deleted and recreated.

      // However, if at some point you need to add a new table, you can't call onCreate again!
      // So, you must change the database version because, as we agreed, the database is created only once.

      // When adding something new, such as a new table or new column, you need to increase the database version,
      // and when you change the version, the onUpgrade function will be called automatically.
      // This function helps update the database structure when the version changes,
      // ensuring that new tables or columns are added without deleting existing data.
      onUpgrade: _onUpgrade,
    );
    return myDb;
  }

  _onCreate(Database db, int version) async {
    // TEXT ---> String
    // to add more than one table use Batch better than db.execute()
    Batch batch = db.batch();

    batch.execute('''
    CREATE TABLE "student" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "gender" TEXT,
    "email" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "pass" TEXT NOT NULL,
    )''');

    // batch.commit() is used to execute all the instructions at once,
    // meaning it creates all the tables in a single operation ".commit()" and finalizes the batch execution efficiently.
    // So, I don't have to wait multiple times and use await multiple times.
    // Instead, I will use await only once, and all the tables will be created in that single execution.
    await batch.commit();
  }

  // _onUpgrade will be automatically called when you change the version of database
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onUpgrade==================================");
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }

  // SELECT method
  selectData(String sql) async {
    Database? myDb = await db;
    // rawQuery --> for "SELECT * from..."
    List<Map<String, Object?>> response = await myDb!.rawQuery(sql);
    return response;
  }

  // INSERT method
  insertData(String sql) async {
    Database? myDb = await db;
    // rawInsert --> for "INSERT INTO"
    // rawInsert returns an integer, which represents the ID of the last inserted row.
    // The value can be 0, 1, 2, or more, depending on the ID of the last inserted row.
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  // UPDATE method
  updateData(String sql) async {
    Database? myDb = await db;
    // rawUpdate --> for "UPDATE TABLE SET...."
    // rawUpdate returns an integer, which indicates the number of rows that were updated.
    // The value can be 0, 1, 2, or more, depending on how many rows were successfully updated.
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  // DELETE method
  deleteData(String sql) async {
    Database? myDb = await db;
    // rawDelete --> for "DELETE FROM ...."
    // rawDelete returns an integer, which indicates the number of rows that were deleted.
    // The value can be 0, 1, 2, or more, depending on how many rows were successfully deleted.
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  // Delete all Database
  myDeleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String alaPath = join(databasePath, 'marawan.db');
    await deleteDatabase(alaPath);
  }

  // =======================================================================================
  // Great builtin methods and shortcuts

  // SELECT
  // DELETE
  // UPDATE
  // INSERT

  // SELECT method --> now we need only name of the table to get all rows
  select(String table) async {
    Database? myDb = await db;
    // rawQuery --> for "SELECT * from..."
    List<Map<String, Object?>> response = await myDb!.query(table);
    return response;
  }

  // INSERT method --> now we need only name of the table and values to insert new raw
  insert(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    // rawInsert --> for "INSERT INTO"
    // rawInsert returns an integer, which represents the ID of the last inserted row.
    // The value can be 0, 1, 2, or more, depending on the ID of the last inserted row.
    int response = await myDb!.insert(table, values);
    return response;
  }

  // UPDATE method
  update(String table, Map<String, Object?> values, String? myWhere) async {
    Database? myDb = await db;
    // rawUpdate --> for "UPDATE TABLE SET...."
    // rawUpdate returns an integer, which indicates the number of rows that were updated.
    // The value can be 0, 1, 2, or more, depending on how many rows were successfully updated.
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }

  // DELETE method
  delete(String table, String? myWhere) async {
    Database? myDb = await db;
    // rawDelete --> for "DELETE FROM ...."
    // rawDelete returns an integer, which indicates the number of rows that were deleted.
    // The value can be 0, 1, 2, or more, depending on how many rows were successfully deleted.
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }
}
