import 'package:flutter/material.dart';

import '../../domain/usecases/expense_usecases/get_daily_expense_summary.dart';
import '../../domain/usecases/expense_usecases/get_monthly_expense_summary.dart';
import '../../domain/usecases/expense_usecases/get_weekly_expense_summary.dart';

class ExpenseSummaryProvider extends ChangeNotifier {
  final GetDailyExpenseSummaryUseCase dailySummaryUseCase;
  final GetWeeklyExpenseSummaryUseCase weeklySummaryUseCase;
  final GetMonthlyExpenseSummaryUseCase monthlySummaryUseCase;

  bool _isLoading = false;
  double _dailyTotal = 0;
  double _weeklyTotal = 0;
  double _monthlyTotal = 0;

  bool get isLoading => _isLoading;
  double get dailyTotal => _dailyTotal;
  double get weeklyTotal => _weeklyTotal;
  double get monthlyTotal => _monthlyTotal;

  ExpenseSummaryProvider({
    required this.dailySummaryUseCase,
    required this.weeklySummaryUseCase,
    required this.monthlySummaryUseCase,
  });

  Future<void> fetchDailySummary() async {
    _isLoading = true;
    notifyListeners();

    _dailyTotal = await dailySummaryUseCase.call();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchWeeklySummary() async {
    _isLoading = true;
    notifyListeners();

    _weeklyTotal = await weeklySummaryUseCase.call();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMonthlySummary() async {
    _isLoading = true;
    notifyListeners();

    _monthlyTotal = await monthlySummaryUseCase.call();
    _isLoading = false;
    notifyListeners();
  }
}
