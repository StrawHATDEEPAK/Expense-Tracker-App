import '../../../core/utils/expense_summary_util.dart';
import '../../repositories/expense_repository.dart';

class GetDailyExpenseSummaryUseCase {
  final ExpenseRepository repository;

  GetDailyExpenseSummaryUseCase(this.repository);

  Future<double> call() async {
    final expenses = await repository.getExpenses();
    final today = DateTime.now();

    double total = 0;
    for (var expense in expenses) {
      if (ExpenseUtils.isSameDay(DateTime.parse(expense.date), today)) {
        total += expense.amount;
      }
    }
    return total;
  }
}
