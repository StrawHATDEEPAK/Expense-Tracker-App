import '../../../core/utils/expense_summary_util.dart';
import '../../repositories/expense_repository.dart';

class GetWeeklyExpenseSummaryUseCase {
  final ExpenseRepository repository;

  GetWeeklyExpenseSummaryUseCase(this.repository);

  Future<double> call() async {
    final expenses = await repository.getExpenses();

    double total = 0;
    for (var expense in expenses) {
      if (ExpenseUtils.isSameWeek(DateTime.parse(expense.date))) {
        total += expense.amount;
      }
    }
    return total;
  }
}
