import 'package:restaurant/data/model/restaurant_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tbRestaurant = 'tb_restaurant';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/restaurant.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tbRestaurant (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating DOUBLE
      );
    ''');
  }

  Future<int> insertWatchlist(RestaurantTable restaurant) async {
    final db = await database;
    return await db!.insert(_tbRestaurant, restaurant.toJson());
  }

  Future<int> removePlaceList(String id) async {
    final db = await database;
    return await db!.delete(
      _tbRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getPlaceById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tbRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getPlaceList() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
    await db!.query(_tbRestaurant);

    return results;
  }


}
