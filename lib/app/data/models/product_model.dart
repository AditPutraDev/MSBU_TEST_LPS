import 'package:inventory/app/data/datasource/local/database_manager.dart';

class Product {
  int id;
  String namaBarang;
  String kodeBarang;
  int jumlahBarang;
  DateTime? tanggal;

  Product({
    this.id = 0,
    this.namaBarang = '',
    this.kodeBarang = '',
    this.jumlahBarang = 0,
    this.tanggal,
  });

  factory Product.fromSqfliteDB(Map<String, dynamic> map) => Product(
        id: map[DatabaseManager.columnId] ?? 0,
        jumlahBarang: map[DatabaseManager.columnQTY] ?? 0,
        kodeBarang: map[DatabaseManager.columnCode] ?? '',
        namaBarang: map[DatabaseManager.columnName] ?? '',
        tanggal: map[DatabaseManager.columnDate] != null
            ? DateTime.tryParse(map[DatabaseManager.columnDate]) ??
                DateTime.now()
            : DateTime.now(),
      );
}
