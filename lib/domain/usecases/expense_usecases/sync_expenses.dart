import '../../repositories/expense_repository.dart';

class SyncExpenses {
  final ExpenseRepository repository;

  SyncExpenses(this.repository);

  Future<void> call() async {
    await repository.syncExpenses();
  }
}
