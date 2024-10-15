import '../../../core/utils/expense_summary_util.dart';
import '../../repositories/expense_repository.dart';

class GetMonthlyExpenseSummaryUseCase {
  final ExpenseRepository repository;

  GetMonthlyExpenseSummaryUseCase(this.repository);

  Future<double> call() async {
    final expenses = await repository.getExpenses();
    final today = DateTime.now();

    double total = 0;
    for (var expense in expenses) {
      if (ExpenseUtils.isSameMonth(DateTime.parse(expense.date), today)) {
        total += expense.amount;
      }
    }
    return total;
  }
}
