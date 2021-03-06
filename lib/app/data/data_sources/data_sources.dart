// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_online/app/config/app_enum.dart';

import '../../config/app_function.dart';
import '../models/categories.dart';
import '../models/settings.dart';
import '../models/transactions.dart';

class DataSources extends GetConnect {
  @override
  void onInit() async {}

  static const String _db_name = "wallet.db";
  static const String _id = "id";
  static const String _state = "state";
  static const String _title = "title";

  static const String _tbl_settings = "settings";
  static const String _currency = "currency";
  static const String _language = "language";
  static const String _tbl_settings_query = '''
    CREATE TABLE $_tbl_settings(
        $_id INTEGER PRIMARY KEY AUTOINCREMENT, 
        $_currency TEXT NOT NULL,
        $_language TEXT NOT NULL
  );''';
  static String _tbl_settings_data_query = '''
    INSERT INTO $_tbl_settings ($_id, $_currency, $_language) VALUES 
      (1, '${AppCurrencies.MAD.name}', '${AppLanguages.en.name}')
    ''';

  static const String _tbl_category = "categories";
  static const String _color = "color";
  static const String _total = "total";
  static const String _tbl_category_query = '''
    CREATE TABLE $_tbl_category(
        $_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_color INTEGER NOT NULL,
        $_title TEXT NOT NULL,
        $_state BIT NOT NULL
  );''';
  static String _tbl_category_data_query = '''
    INSERT INTO $_tbl_category($_id, $_color, $_title, $_state)VALUES
      (1, '${AppFunction.getRandomColor}', 'Others',          0),
      (2, '${AppFunction.getRandomColor}', 'Salary',          0),
      (3, '${AppFunction.getRandomColor}', 'Others',          1),
      (4, '${AppFunction.getRandomColor}', 'Food',            1),
      (5, '${AppFunction.getRandomColor}', 'Clothes',         1),
      (6, '${AppFunction.getRandomColor}', 'Transportation',  1),
      (7, '${AppFunction.getRandomColor}', 'Shopping',        1),
      (8, '${AppFunction.getRandomColor}', 'Bills',           1)
  ''';

  static const String _tbl_transaction = "transactions";
  static const String _description = "description";
  static const String _date = "date";
  static const String _amount = "amount";
  static const String _categoryID = "category_id";
  static const String _tbl_transaction_query = '''
    CREATE TABLE $_tbl_transaction(
        $_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_amount DOUBLE NOT NULL,
        $_description TEXT,
        $_date DATETIME DEFAULT CURRENT_TIMESTAMP,
        $_state BIT NOT NULL,
        $_categoryID INTEGER NOT NULL
  );''';
  static String _tbl_transaction_data_query = '''
   INSERT INTO $_tbl_transaction ($_date, $_description, $_amount, $_categoryID, $_state) VALUES
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 0, DateTime.now().hour, DateTime.now().minute)}', 'Others Stuff', 100, 3, 1),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 0, DateTime.now().hour, DateTime.now().minute)}', 'Raise', 1000, 2, 0),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, DateTime.now().hour, DateTime.now().minute)}', '', 1000, 5, 1),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, DateTime.now().hour, DateTime.now().minute)}', 'Dinner', 100, 4, 1),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2, DateTime.now().hour, DateTime.now().minute)}', '', 500, 7, 1),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2, DateTime.now().hour, DateTime.now().minute)}', 'Gift', 1000, 1, 0),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3, DateTime.now().hour, DateTime.now().minute)}', '', 5000, 2, 0),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3, DateTime.now().hour, DateTime.now().minute)}', 'Wi-Fi', 250, 8, 1),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 4, DateTime.now().hour, DateTime.now().minute)}', 'Lunch', 100, 4, 1),
    ('${DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 4, DateTime.now().hour, DateTime.now().minute)}', '', 75, 6, 1)
   ''';

  /// TODO : About DataBase
  Future<Database> get _database async {
    return await openDatabase(
      join(await getDatabasesPath(), _db_name),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(_tbl_settings_query);
        await db.execute(_tbl_category_query);
        await db.execute(_tbl_transaction_query);

        ///
        await db.execute(_tbl_settings_data_query);
        await db.execute(_tbl_category_data_query);
        if (kDebugMode) {
          await db.execute(_tbl_transaction_data_query);
        }
      },
    );
  }

  /// TODO : About Settings
  Future<Settings> get getSettings async {
    final db = await _database;
    final List<Map<String, dynamic>> response = await db.query(_tbl_settings);
    return Settings.fromMap(response.first);
  }

  Future updateSettings(Settings settings) async {
    final db = await _database;
    final response = await db.update(
      _tbl_settings,
      settings.toMap(),
      where: "$_id = ?",
      whereArgs: [settings.id],
    );
    return response;
  }

  /// TODO : About Categories
  Future<List<Categories>> get getCategories async {
    final db = await _database;
    final List<Map<String, dynamic>> response = await db.query(
      _tbl_category,
      orderBy: "$_id DESC",
    );
    return categoriesFromMap(response);
  }

  Future<Categories> getCategory(int id) async {
    final db = await _database;
    final List<Map<String, dynamic>> response = await db.query(
      _tbl_category,
      where: "$_id = ?",
      whereArgs: [id],
    );
    return Categories.fromMap(response.first);
  }

  Future insertCategory(Categories category) async {
    final db = await _database;
    final response = await db.insert(
      _tbl_category,
      category.toInsert(),
    );
    return response;
  }

  Future updateCategory(Categories category) async {
    final db = await _database;
    final response = await db.update(
      _tbl_category,
      category.toUpdate(),
      where: "$_id = ?",
      whereArgs: [category.id],
    );
    return response;
  }

  Future deleteCategory(int id) async {
    final db = await _database;
    final response = await db.delete(
      _tbl_category,
      where: "$_id = ?",
      whereArgs: [id],
    );
    return response;
  }

  /// TODO : About Transactions
  Future<List<Transactions>> get getTransactions async {
    final db = await _database;
    final List<Map<String, dynamic>> response = await db.query(
      _tbl_transaction,
      orderBy: "$_id DESC",
    );
    return transactionsFromMap(response);
  }

  Future insertTransaction(Transactions transaction) async {
    final db = await _database;
    final response = await db.insert(
      _tbl_transaction,
      transaction.toInsert(),
    );
    return response;
  }

  Future deleteTransaction(int id) async {
    final db = await _database;
    final response = await db.delete(
      _tbl_transaction,
      where: "$_id = ?",
      whereArgs: [id],
    );
    return response;
  }

  /// TODO : About Statistics
  Future<List<Categories>> get getStatistics async {
    final db = await _database;
    final String query = '''
          SELECT $_tbl_category.*, SUM($_amount) as $_total
          FROM $_tbl_category
          LEFT JOIN $_tbl_transaction
          ON $_tbl_category.$_id = $_tbl_transaction.$_categoryID
          GROUP BY $_tbl_category.$_id
          ORDER BY $_total DESC, $_id DESC
    ''';
    final List<Map<String, dynamic>> response = await db.rawQuery(query);
    return categoriesFromMap(response);
  }
}
