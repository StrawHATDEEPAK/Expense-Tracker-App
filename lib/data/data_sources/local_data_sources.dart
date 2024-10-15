import 'package:sqflite/sqflite.dart';

import '../../core/entities/expense.dart';
import '../../core/entities/user.dart';
import '../db/expense_db.dart';

class LocalDataSource {
  final ExpenseDB expenseDB;

  LocalDataSource(this.expenseDB);

  Future<void> saveUser(User user) async {
    final db = await expenseDB.database;
    await db?.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser() async {
    final db = await expenseDB.database;
    final result = await db?.query('users');

    if (result != null && result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null; // Return null if no user found
  }

  Future<bool> addExpense(Expense expense) async {
    try {
      final db = await expenseDB.database;

      if (db == null) {
        return false;
      }

      final result = await db.insert(
        'expenses',
        expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return result != 0; // If result is not 0, insertion is successful.
    } catch (e) {
      // Handle any exceptions or errors that occur during insertion

      return false;
    }
  }

  Future<List<Expense>> getExpenses() async {
    final db = await expenseDB.database;
    final result = await db?.query('expenses');
    return result?.map((e) => Expense.fromMap(e)).toList() ?? [];
  }

  Future<void> deleteExpense(Expense expense) async {
    final db = await expenseDB.database;
    await db?.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> updateExpense(Expense expense) async {
    final db = await expenseDB.database;
    await db?.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> logout() async {
    await expenseDB.clearDatabase();
  }
}
