import 'package:expenseapp/constants/icons.dart';
import 'package:expenseapp/models/ex_category.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider with ChangeNotifier {
  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;
  Database? _database;
  Future<Database> get database async {
    // databse directory
    final dbDirectory = await getDatabasesPath();
    // database name
    const dbName = 'expense.db';
    // the full path
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return _database!;
  }

  static const cTable = 'categoryTable';
  static const eTable = 'expenseTable';
  Future<void> _createDb(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute(''' CREATE TABLE $cTable(
      title TEXT,
      entries INTEGER,
      totalAmount TEXT
    )''');
      await txn.execute('''CREATE TABLE $eTable(
      id INTEGER,
      title TEXT,
      anmount TEXT,
      date TEXT,
      category TEXT
    )''');
      for (int i = 0; i < icons.length; i++) {
        await txn.insert(cTable, {
          'title': icons.keys.toList()[i],
          'entries': 0,
          'totalAmount': (0.0).toString(),
        });
      }
    });
  }

  Future<List<ExpenseCategory>> fetchCategories() async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(cTable).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<ExpenseCategory> nList = List.generate(converted.length,
            (index) => ExpenseCategory.fromString(converted[index]));
        _categories = nList;
        return _categories;
      });
    });
  }
}
