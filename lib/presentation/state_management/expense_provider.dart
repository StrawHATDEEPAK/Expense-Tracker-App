import 'package:flutter/foundation.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/add_expense.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/delete_expense.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/get_expenses.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/update_expense.dart';

import '../../core/entities/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  final AddExpense addExpenseUseCase;
  final GetExpenses getExpensesUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;
  final UpdateExpenseUseCase updateExpenseUseCase;

  ExpenseProvider(
      {required this.addExpenseUseCase,
      required this.getExpensesUseCase,
      required this.deleteExpenseUseCase,
      required this.updateExpenseUseCase});

  bool _isLoading = false;
  String _selectedDate = DateTime.now().toString().substring(0, 10);
  List<Expense> _expenses = [];
  int selectedCategory = 0;
  bool get isLoading => _isLoading;
  List<Expense> get expenses => _expenses;
  String get selectedDate => _selectedDate;

  void selectDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> fetchExpenses() async {
    _isLoading = true;
    notifyListeners();

    _expenses = await getExpensesUseCase.call();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sortByDate() async {
    _isLoading = true;
    notifyListeners();
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sortByAmount() async {
    _isLoading = true;
    notifyListeners();
    _expenses.sort((a, b) => b.amount.compareTo(a.amount));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await addExpenseUseCase.call(expense);
    await fetchExpenses(); // Refresh the expenses list after adding a new expense
  }

  void selectCategory(int index) {
    selectedCategory = index;
    notifyListeners();
  }

  Future<void> deleteExpense(Expense expense) async {
    await deleteExpenseUseCase.call(expense);
    expenses.remove(expense);
    notifyListeners(); // Refresh the expenses list after adding a new expense
  }

  Future<void> updateExpense(Expense expense) async {
    await updateExpenseUseCase.call(expense);
    await fetchExpenses(); // Refresh the expenses list after adding a new expense
  }
}
