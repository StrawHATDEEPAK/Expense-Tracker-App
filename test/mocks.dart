import 'package:mockito/annotations.dart';
import 'package:personal_expense_tracker/data/data_sources/firestore_data_sources.dart';
import 'package:personal_expense_tracker/data/data_sources/local_data_sources.dart';
import 'package:personal_expense_tracker/domain/repositories/auth_repository.dart';
import 'package:personal_expense_tracker/domain/repositories/expense_repository.dart';

@GenerateMocks(
    [AuthRepository, LocalDataSource, FirestoreDataSource, ExpenseRepository])
void main() {}
