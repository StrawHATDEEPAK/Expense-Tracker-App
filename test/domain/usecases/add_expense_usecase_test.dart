import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_expense_tracker/core/entities/expense.dart';
import 'package:personal_expense_tracker/domain/usecases/expense_usecases/add_expense.dart';

import '../../mocks.mocks.dart';

void main() {
  late AddExpense addExpenseUseCase;
  late MockExpenseRepository mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    addExpenseUseCase = AddExpense(mockExpenseRepository);
  });

  final tExpense = Expense(
      id: '1',
      title: 'Shopping',
      amount: 100,
      description: 'Groceries',
      date: DateTime.now().toString().substring(0, 10));

  test('should call repository to add expense', () async {
    // Arrange
    when(mockExpenseRepository.addExpense(tExpense))
        .thenAnswer((_) async => true);

    // Act
    final result = await addExpenseUseCase.call(tExpense);

    // Assert
    expect(result, true);
    verify(mockExpenseRepository.addExpense(tExpense)).called(1);
  });

  test('should throw an exception when adding expense fails', () async {
    // Arrange
    when(mockExpenseRepository.addExpense(tExpense))
        .thenThrow(Exception('Failed to add expense'));

    // Act
    final call = addExpenseUseCase.call(tExpense);

    // Assert
    expect(() => call, throwsA(isA<Exception>()));
    verify(mockExpenseRepository.addExpense(tExpense)).called(1);
  });
}
