import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_model.dart';

class DatabaseHelper {
  String _databasName = "tfcontact.db";
  String _whoViewedMyTagsTable = "whoViewedMyTags";
  String _tagsTable = "tags";
  String _searchHistoryTable = "searchHistory";
  String _usersTable = "users";
  String _myContactsTable = "myContacts";

  String _columnId = "id";
  String _columnFullName = "fullname";
  String _columnPhone = "phone";
  String _columnProfileImage = "profile_image";
  String _columnCreatedAt = "created_at";
  String _columnsay = "say";
  String _columncount = "count";
  String _columnlen = "len";
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
      CREATE TABLE IF NOT EXISTS $_searchHistoryTable (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $_columnFullName TEXT NULL, 
        $_columnPhone TEXT NOT NULL, 
        $_columnProfileImage TEXT NULL, 
        $_columnCreatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tagsTable (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $_columnFullName TEXT NULL
      )
    ''');

    await db.execute('''
     CREATE TABLE IF NOT EXISTS $_whoViewedMyTagsTable (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $_columnFullName TEXT NULL,
        $_columnlen INTEGER NULL
      )
    ''');

    await db.execute('''
         CREATE TABLE IF NOT EXISTS $_usersTable (
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnFullName TEXT NULL,
          $_columnProfileImage TEXT  NULL,
          $_columnsay INTEGER NULL
        )
      ''');
    await db.execute('''
         CREATE TABLE IF NOT EXISTS $_myContactsTable (
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnFullName TEXT NULL,
          $_columnProfileImage TEXT  NULL,
          $_columncount INTEGER NULL
        )
      ''');
  }

  // Future<List<NumberSearchTagModel>> getTags() async {
  //   Database db = await instance.database;
  //   var results = await db.query('tags', orderBy: "id DESC");
  //   return results.map((json) => NumberSearchTagModel.fromJson(json)).toList();
  // }

  // Future<List<NumberSearchUserModel>> getWhoViewedMyTags() async {
  //   Database db = await instance.database;
  //   var results = await db.query('whoViewedMyTags', orderBy: "id DESC");
  //   List<NumberSearchUserModel> resultList = results.isNotEmpty
  //       ? results.map((c) => NumberSearchUserModel.fromJson(c)).toList()
  //       : [];
  //   return resultList;
  // }

  // Future<List<FeaturesWhoIsHereUserModel>> getWhoIsHereUsers() async {
  //   final db = await database;
  //   var results = await db.query('myContacts', orderBy: "id DESC");
  //   List<FeaturesWhoIsHereUserModel> resultList = results.isNotEmpty
  //       ? results.map((c) => FeaturesWhoIsHereUserModel.fromJson(c)).toList()
  //       : [];
  //   return resultList;
  // }

  // Future<List<FeaturesUserModel>> getUsers() async {
  //   final db = await database;
  //   var results = await db.query('users', orderBy: "id DESC");
  //   List<FeaturesUserModel> resultList = results.isNotEmpty
  //       ? results.map((c) => FeaturesUserModel.fromJson(c)).toList()
  //       : [];
  //   return resultList;
  // }

  // Future<List<SearchHistoryData>> getSarchHistories() async {
  //   final db = await database;
  //   var results = await db.query('searchHistory', orderBy: "id DESC");
  //   List<SearchHistoryData> resultList = results.isNotEmpty
  //       ? results.map((c) => SearchHistoryData.fromJson(c)).toList()
  //       : [];
  //   return resultList;
  // }

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
        batch.delete(_whoViewedMyTagsTable);
        batch.delete(_tagsTable);
        batch.delete(_searchHistoryTable);
        batch.delete(_usersTable);
        batch.delete(_myContactsTable);
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
}
