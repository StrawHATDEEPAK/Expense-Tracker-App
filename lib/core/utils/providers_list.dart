import 'package:personal_expense_tracker/data/data_sources/firestore_data_sources.dart';
import 'package:personal_expense_tracker/data/data_sources/local_data_sources.dart';
import 'package:personal_expense_tracker/data/db/expense_db.dart';
import 'package:personal_expense_tracker/data/repositories/auth_repository_impl.dart';
import 'package:personal_expense_tracker/data/repositories/expense_repository_impl.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/add_expense.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/delete_expense.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/get_monthly_expense_summary.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/update_expense.dart';
import 'package:personal_expense_tracker/domain/usecases/user_usecases/login_usecase.dart';
import 'package:personal_expense_tracker/domain/usecases/user_usecases/logout.dart';
import 'package:personal_expense_tracker/domain/usecases/user_usecases/register_usecase.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../domain/usecases/expense_usecases/get_daily_expense_summary.dart';
import '../../domain/usecases/expense_usecases/get_expenses.dart';
import '../../domain/usecases/expense_usecases/get_weekly_expense_summary.dart';
import '../../presentation/state_management/expense_provider.dart';
import '../../presentation/state_management/expense_summary_provider.dart';
import '../../presentation/state_management/user_provider.dart';

// Instantiate the database

List<SingleChildWidget> providersList({required ExpenseDB expenseDb}) {
  // Create instances of data sources
  final localDataSource = LocalDataSource(expenseDb);
  final fireStoreDataSource = FirestoreDataSource();

// Pass data sources to the repository
  final authRepository =
      AuthRepositoryImpl(localDataSource, fireStoreDataSource);
  final expenseRepository = ExpenseRepositoryImpl(
    localDataSource,
    fireStoreDataSource,
  );
  return [
    ChangeNotifierProvider(
      create: (_) => UserProvider(
          logoutUseCase: LogoutUseCase(authRepository),
          loginUseCase: LoginUseCase(authRepository),
          signupUseCase: SignupUseCase(repository: authRepository)),
    ),
    ChangeNotifierProvider(
      create: (_) => ExpenseProvider(
        addExpenseUseCase: AddExpense(expenseRepository),
        getExpensesUseCase: GetExpenses(expenseRepository),
        deleteExpenseUseCase: DeleteExpenseUseCase(expenseRepository),
        updateExpenseUseCase: UpdateExpenseUseCase(expenseRepository),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => ExpenseSummaryProvider(
        dailySummaryUseCase: GetDailyExpenseSummaryUseCase(expenseRepository),
        weeklySummaryUseCase: GetWeeklyExpenseSummaryUseCase(expenseRepository),
        monthlySummaryUseCase:
            GetMonthlyExpenseSummaryUseCase(expenseRepository),
      ),
    ),
  ];
}
