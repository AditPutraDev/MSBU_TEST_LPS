// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._private();

  static DatabaseManager instance = DatabaseManager._private();
  Database? _database;
  static const columnId = 'id';
  static const columnName = 'nama_barang';
  static const columnCode = 'kode_barang';
  static const columnQTY = 'jumlah_barang';
  static const columnDate = 'tanggal';
  static const dbName = 'inventory.db';
  static const tableInventory = 'inventory';

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute('''
            CREATE TABLE $tableInventory (
              $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              $columnName TEXT NOT NULL,
              $columnCode TEXT NOT NULL,
              $columnQTY INTEGER NOT NULL,
              $columnDate TEXT NOT NULL
            )
          ''');
      },
    );
  }

  Future closeDatabase() async {
    _database = await instance.database;
    _database!.close();
  }
}
