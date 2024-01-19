import 'package:rupiyo_seller/Database/DatabaseHelper.dart';
import 'package:rupiyo_seller/Models/Shop.dart';

class ShopService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> initializeDatabase() async {
    await _databaseHelper.initializeDatabase();
  }

  Future<void> insertShop(Shop shop) async {
    // Add business logic here if needed
    await _databaseHelper.insertShop(shop);
  }
}
