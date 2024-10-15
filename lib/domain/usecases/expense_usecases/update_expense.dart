import '../../../core/entities/expense.dart';
import '../../repositories/expense_repository.dart';

class UpdateExpenseUseCase {
  final ExpenseRepository repository;

  UpdateExpenseUseCase(this.repository);

  Future<void> call(Expense expense) async {
    await repository.updateExpense(expense);
  }
}
