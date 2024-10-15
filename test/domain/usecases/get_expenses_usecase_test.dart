import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_expense_tracker/core/entities/expense.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/get_expenses.dart';

import '../../mocks.mocks.dart';

void main() {
  late GetExpenses fetchExpensesUseCase;
  late MockExpenseRepository mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    fetchExpensesUseCase = GetExpenses(mockExpenseRepository);
  });

  final tExpenses = [
    Expense(
        id: '1',
        title: 'Shopping',
        amount: 100,
        description: 'Groceries',
        date: DateTime.now().toString().substring(0, 10)),
    Expense(
        id: '2',
        title: 'Other',
        amount: 50,
        description: 'Fuel',
        date: DateTime.now().toString().substring(0, 10)),
  ];

  test('should return list of expenses from the repository', () async {
    // Arrange
    when(mockExpenseRepository.getExpenses())
        .thenAnswer((_) async => tExpenses);

    // Act
    final result = await fetchExpensesUseCase.call();

    // Assert
    expect(result, tExpenses);
    verify(mockExpenseRepository.getExpenses()).called(1);
  });

  test('should throw an exception when fetching expenses fails', () async {
    // Arrange
    when(mockExpenseRepository.getExpenses())
        .thenThrow(Exception('Failed to fetch expenses'));

    // Act
    final call = fetchExpensesUseCase.call();

    // Assert
    expect(() => call, throwsA(isA<Exception>()));
    verify(mockExpenseRepository.getExpenses()).called(1);
  });
}
