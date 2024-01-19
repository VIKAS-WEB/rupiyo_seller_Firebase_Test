import 'package:rupiyo_seller/Models/Shop.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;
  Future<void> initializeDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'Rupeyo_Seller.db');
    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // Handle database upgrade if needed
      },
    );
  }

  void _createTables(Database db) {
    db.execute('''
        CREATE TABLE IF NOT EXISTS shops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        shopName TEXT,
        categories TEXT,
        ShopAddress TEXT,
      )
   ''');
  }

  Future<void> insertShop(Shop shop) async {
    await _database.insert(
      'shops',
      {
        'shopName': shop.shopName,
        'categories': shop.categories,
        'ShopAddress': shop.Address,

        // Add other columns as needed
      },
    );
  }
}
