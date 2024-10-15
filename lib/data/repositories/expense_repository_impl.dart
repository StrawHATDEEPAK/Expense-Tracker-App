import '../../core/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../data_sources/firestore_data_sources.dart';
import '../data_sources/local_data_sources.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final LocalDataSource localDataSource;
  final FirestoreDataSource firestoreDataSource;

  ExpenseRepositoryImpl(this.localDataSource, this.firestoreDataSource);

  @override
  Future<bool> addExpense(Expense expense) async {
    bool localResult = await localDataSource.addExpense(expense);

    // Add expense to Firestore database
    bool remoteResult = await firestoreDataSource.addExpense(expense);

    // Return true if both operations succeeded, otherwise return false
    return localResult && remoteResult;
  }

  @override
  Future<List<Expense>> getExpenses() async {
    var expenses = await localDataSource.getExpenses();

    if (expenses.isEmpty) {
      expenses = await firestoreDataSource.getExpenses();

      for (var expense in expenses) {
        await localDataSource.addExpense(expense);
      }
    }

    return expenses;
  }

  @override
  Future<void> syncExpenses() async {
    // Logic for syncing expenses with Firestore
    final expenses = await localDataSource.getExpenses();
    await firestoreDataSource.syncExpenses(expenses);
  }

  @override
  Future<void> deleteExpense(Expense expense) async {
    await localDataSource.deleteExpense(expense);
    await firestoreDataSource.deleteExpense(expense);
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await localDataSource.updateExpense(expense);
    await firestoreDataSource.updateExpense(expense);
  }
}
