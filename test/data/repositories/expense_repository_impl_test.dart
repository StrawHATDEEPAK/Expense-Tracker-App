import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_expense_tracker/core/entities/expense.dart';
import 'package:personal_expense_tracker/data/repositories/expense_repository_impl.dart';

import '../../mocks.mocks.dart';

void main() {
  late ExpenseRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;
  late MockFirestoreDataSource mockFireStoreDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockFireStoreDataSource = MockFirestoreDataSource();
    repository =
        ExpenseRepositoryImpl(mockLocalDataSource, mockFireStoreDataSource);
  });

  final tExpense = Expense(
      id: '1',
      title: "Shopping",
      amount: 100,
      description: 'Groceries',
      date: DateTime.now().toString().substring(0, 10));
  final tExpenses = [tExpense];

  test('should return list of expenses from local data source', () async {
    // Arrange
    when(mockLocalDataSource.getExpenses()).thenAnswer((_) async => tExpenses);

    // Act
    final result = await repository.getExpenses();

    // Assert
    expect(result, tExpenses);
    verify(mockLocalDataSource.getExpenses()).called(1);
  });

  test('should save expense to local and remote data source', () async {
    // Arrange
    when(mockLocalDataSource.addExpense(tExpense))
        .thenAnswer((_) async => true);
    when(mockFireStoreDataSource.addExpense(tExpense))
        .thenAnswer((_) async => true);

    // Act
    final result = await repository.addExpense(tExpense);

    // Assert
    expect(result, true);
    verify(mockLocalDataSource.addExpense(tExpense)).called(1);
    verify(mockFireStoreDataSource.addExpense(tExpense)).called(1);
  });

  test('should throw an exception when adding expense fails', () async {
    // Arrange
    when(mockLocalDataSource.addExpense(tExpense))
        .thenThrow(Exception('Failed to add expense'));

    // Act
    final call = repository.addExpense(tExpense);

    // Assert
    expect(() => call, throwsA(isA<Exception>()));
    verify(mockLocalDataSource.addExpense(tExpense)).called(1);
  });
}
