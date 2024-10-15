import '../../../core/entities/expense.dart';
import '../../repositories/expense_repository.dart';

class DeleteExpenseUseCase {
  final ExpenseRepository repository;

  DeleteExpenseUseCase(this.repository);

  Future<void> call(Expense expense) async {
    await repository.deleteExpense(expense);
  }
}
