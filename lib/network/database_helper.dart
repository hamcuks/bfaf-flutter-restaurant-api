import 'package:dicoding_submission_restaurant_app_api/model/favourite_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;
  static String _tableName = 'favourite';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> addFavourite(FavouriteModel data) async {
    final db = await database;
    await db.insert(_tableName, data.toJson());
  }

  Future<List<FavouriteModel>> getFavourite() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);

    return result.map((e) => FavouriteModel.fromJson(e)).toList();
  }

  Future<void> deleteFavourite(String id) async {
    final db = await database;

    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<Map> getFavouriteById(String id) async {
    final db = await database;

    var result = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();

    var db = openDatabase(
      '$path/$_tableName.db',
      onCreate: (db, ver) async {
        await db.execute(
            'CREATE TABLE $_tableName (id TEXT PRIMARY KEY, name TEXT, pictureId TEXT, city TEXT, rating TEXT)');
      },
      version: 1,
    );

    return db;
  }

  Future<void> deleteDb() async {
    var path = await getDatabasesPath();
    await deleteDatabase('$path/$_tableName.db');
  }
}
