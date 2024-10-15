import 'package:sqflite/sqflite.dart';

class ExpenseDB {
  static final ExpenseDB _instance = ExpenseDB._internal();
  static Database? _database;

  ExpenseDB._internal();

  factory ExpenseDB() => _instance;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    // Define the path to store the database
    String path = '${await getDatabasesPath()}expense_tracker.db';

    // Create the database and the user table
    print('Dataabase Opened');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Create the 'expenses' and 'users' tables
    await db.execute('''
      CREATE TABLE expenses (
        id TEXT PRIMARY KEY,
        amount REAL,
        title TEXT,
        description TEXT,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT
      )
    ''');
  }

  Future<void> clearDatabase() async {
    final db = await database;
    if (db != null) {
      await db.delete('expenses'); // Clear the 'expenses' table
      await db.delete('users'); // Clear the 'users' table
    }
  }
}
