import 'package:sqflite/sqflite.dart';

import '../../models/product_model.dart';
import 'database_manager.dart';

class DatasourceProduct {
  DatasourceProduct._contructor();

  static DatasourceProduct instance = DatasourceProduct._contructor();

  Future<void> create(Product product) async {
    Database db = await DatabaseManager.instance.database;
    db.rawInsert(
      '''INSERT INTO ${DatabaseManager.tableInventory} (${DatabaseManager.columnName},${DatabaseManager.columnCode},${DatabaseManager.columnQTY},${DatabaseManager.columnDate}) VALUES (?,?,?,?);''',
      [
        product.namaBarang.toLowerCase(),
        product.kodeBarang,
        product.jumlahBarang,
        DateTime.now().toIso8601String(),
      ],
    );
  }

  Future<List<Product>> read({String? name}) async {
    Database db = await DatabaseManager.instance.database;
    final product = await db.query(
      DatabaseManager.tableInventory,
      where: name != null ? '${DatabaseManager.columnName} LIKE ?' : null,
      whereArgs: name != null ? ['%${name.toLowerCase()}%'] : null,
      orderBy: '${DatabaseManager.columnDate} DESC'
    );
    var data = product.map((e) => Product.fromSqfliteDB(e)).toList();
    return data;
  }

  Future<void> delete(int id) async {
    Database db = await DatabaseManager.instance.database;

    await db.delete(DatabaseManager.tableInventory,
        where: '${DatabaseManager.columnId} = $id');
  }

  Future<void> update(Product product) async {
    Database db = await DatabaseManager.instance.database;
    await db.update(
      DatabaseManager.tableInventory,
      {
        DatabaseManager.columnName: product.namaBarang,
        DatabaseManager.columnCode: product.kodeBarang,
        DatabaseManager.columnQTY: product.jumlahBarang,
        DatabaseManager.columnDate: DateTime.now().toIso8601String(),
      },
      where: '${DatabaseManager.columnId} = ${product.id}',
    );
  }
}
