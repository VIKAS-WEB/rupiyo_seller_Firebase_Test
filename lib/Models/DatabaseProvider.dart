import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{
  Database? _database;
  Future<Database>get database async{
    //Database Directory
    final dbDirectory = await getDatabasesPath();
    //database name;
    const dbName = 'Rupiyo_Seller.db';
    //full path
    final path  = join(dbDirectory, dbName);
    
    _database =  await openDatabase(path, version: 1, onCreate: _createdb, );
    return _database!;
  }
  // Create DB function
  Future<void> _createdb(Database db, int version) async{

    //create
  }
}