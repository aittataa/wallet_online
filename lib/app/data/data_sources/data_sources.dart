import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_online/app/config/functions/app_function.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/data/models/settings.dart';
import 'package:wallet_online/app/data/models/transactions.dart';

class DataSources extends GetConnect {
  static const String _db_name = "wallet.db";
  static const String _id = "id";
  static const String _state = "state";

  static const String _tbl_settings = "settings";
  static const String _currency = "currency";
  static const String _tbl_settings_query = '''
  CREATE TABLE $_tbl_settings(
        $_id INTEGER PRIMARY KEY AUTOINCREMENT, 
        $_currency TEXT NOT NULL
  )''';
  static const String _tbl_settings_data_query = '''
    INSERT INTO $_tbl_settings ($_id, $_currency) VALUES (1, 'DH')
  ''';

  static const String _tbl_category = "categories";
  static const String _title = "title";
  static const String _color = "color";
  static const String _total = "total";
  static const String _tbl_category_query = '''
  CREATE TABLE $_tbl_category(
      $_id INTEGER PRIMARY KEY AUTOINCREMENT,
      $_title TEXT NOT NULL,
      $_color INTEGER NOT NULL,
      $_state BIT NOT NULL
  );''';
  static String _tbl_category_data_query = '''
  INSERT INTO $_tbl_category($_id, $_title, $_color, $_state)VALUES
    (1, 'Others', '${AppFunction.getRandomColor}', 0),
    (2, 'Salary', '${AppFunction.getRandomColor}', 0),
    (3, 'Others', '${AppFunction.getRandomColor}', 1),
    (4, 'Food', '${AppFunction.getRandomColor}', 1),
    (5, 'Clothes', '${AppFunction.getRandomColor}', 1),
    (6, 'Transportation', '${AppFunction.getRandomColor}', 1),
    (7, 'Shopping', '${AppFunction.getRandomColor}', 1),
    (8, 'Bills', '${AppFunction.getRandomColor}', 1)
  ''';

  static const String _tbl_transaction = "transactions";
  static const String _description = "description";
  static const String _date = "date";
  static const String _amount = "amount";
  static const String _categoryID = "category_id";
  static const String _tbl_transaction_query = '''
  CREATE TABLE $_tbl_transaction(
      $_id INTEGER PRIMARY KEY AUTOINCREMENT,
      $_description TEXT,
      $_date DATETIME DEFAULT CURRENT_TIMESTAMP,
      $_amount DOUBLE NOT NULL,
      $_categoryID INTEGER NOT NULL,
      $_state BIT NOT NULL
  );''';

  static const String _tbl_transaction_data_query = '''
   INSERT INTO $_tbl_transaction ($_description, $_amount, $_categoryID, $_state) VALUES
    ('Others Stuff', 100,  3, 1),
    ('Raise', 1000, 2, 0),
    ('', 1000, 5, 1),
    ('Dinner', 100,  4, 1),
    ('', 500,  7, 1),
    ('Gift', 1000, 1, 0),
    ('', 5000, 2, 0),
    ('Wi-Fi', 250,  8, 1),
    ('Lunch', 100,  4, 1),
    ('', 75,   6, 1)
   ''';

  Future<Database> get _database async {
    return await openDatabase(
      join(await getDatabasesPath(), _db_name),
      version: 1,
      onCreate: (db, version) async {
        /// TODO : Tables
        await db.execute(_tbl_settings_query);
        await db.execute(_tbl_category_query);
        await db.execute(_tbl_transaction_query);

        /// TODO : Data
        await db.execute(_tbl_settings_data_query);
        await db.execute(_tbl_category_data_query);
        await db.execute(_tbl_transaction_data_query);
      },
    );
  }

  /// TODO : About Settings
  Future<List<Settings>> get getSettings async {
    final db = await _database;
    final response = await db.query(_tbl_settings);
    return settingsFromMap(response);
  }

  Future updateSettings(Settings settings) async {
    final db = await _database;
    return await db.update(
      _tbl_settings,
      settings.toMap(),
      where: "$_id = ?",
      whereArgs: [settings.id],
    );
  }

  /// TODO : About Categories
  Future<List<Categories>> get getCategories async {
    final db = await _database;
    final String query = '''
          SELECT $_tbl_category.*, SUM($_amount) as $_total
          FROM $_tbl_category
          LEFT JOIN $_tbl_transaction
          on $_tbl_category.$_id = $_tbl_transaction.$_categoryID
          GROUP BY $_tbl_category.$_id
          ORDER BY $_total DESC , $_id DESC
    ''';
    final response = await db.rawQuery(query);
    return categoriesFromMap(response);
  }

  Future insertCategory(Categories category) async {
    final db = await _database;
    var response = await db.insert(_tbl_category, category.toMap());
    return response;
  }

  /// TODO : About Transactions
  Future<List<Transactions>> get getTransactions async {
    final db = await _database;
    final String query = '''
          SELECT $_tbl_transaction.*, $_title
          FROM $_tbl_transaction INNER JOIN $_tbl_category
          ON $_tbl_transaction.$_categoryID = $_tbl_category.$_id
          ORDER BY $_tbl_transaction.$_id DESC
    ''';
    var response = await db.rawQuery(query);
    return transactionsFromMap(response);
  }

  Future insertTransaction(Transactions transaction) async {
    final db = await _database;
    var response = await db.insert(_tbl_transaction, transaction.toMap());
    return response;
  }

  Future deleteTransaction(int id) async {
    final db = await _database;
    var response = await db.delete(_tbl_transaction, where: "$_id = ?", whereArgs: [id]);
    return response;
  }
}
