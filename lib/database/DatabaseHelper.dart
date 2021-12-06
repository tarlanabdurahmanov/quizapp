import 'dart:io';

import 'package:path/path.dart';
import 'package:quizapp/models/CategoryResponseModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_model.dart';

class DatabaseHelper {
  String _databasName = "milyoncu.db";
  String _categoryTable = "category";

  String _columnId = "id";
  String _columnCategoryName = "category_name";
  String _columnImage = "image";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databasName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_categoryTable (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $_columnCategoryName TEXT NULL, 
        $_columnImage TEXT NULL
      )
    ''');
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    var results = await db.query('category', orderBy: "id ASC");
    List<Category> resultList = results.isNotEmpty
        ? results.map((c) => Category.fromJson(c)).toList()
        : [];
    return resultList;
  }

  Future<int> add({required String table, required DatabaseModel model}) async {
    Database db = await instance.database;
    return await db.insert(table, model.toJson());
  }

  Future<int> remove({required String table, required int id}) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(
      {required String table,
      required DatabaseModel model,
      required int id}) async {
    Database db = await instance.database;
    return await db
        .update(table, model.toJson(), where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteAll({required String table}) async {
    Database db = await instance.database;
    return await db.delete(table);
  }

  Future<void> deleteAllData() async {
    try {
      Database db = await instance.database;
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(_categoryTable);
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
}
