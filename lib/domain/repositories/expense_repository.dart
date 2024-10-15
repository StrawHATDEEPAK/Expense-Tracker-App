import '../../core/entities/expense.dart';

abstract class ExpenseRepository {
  Future<bool> addExpense(Expense expense);
  Future<List<Expense>> getExpenses();
  Future<void> syncExpenses();
  Future<void> deleteExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
}
