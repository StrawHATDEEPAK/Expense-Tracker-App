import 'package:personal_expense_tracker/data/data_sources/firestore_data_sources.dart';

import '../../core/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local_data_sources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalDataSource localDataSource;
  final FirestoreDataSource firestoreDataSource;

  AuthRepositoryImpl(this.localDataSource, this.firestoreDataSource);

  @override
  Future<void> saveUser(User user) async {
    await localDataSource.saveUser(user);
  }

  @override
  Future<User?> getUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<void> logout() async {
    await firestoreDataSource.logout();
    await localDataSource.logout();
  }

  @override
  Future<bool> login(String email, String password) async {
    return await firestoreDataSource.login(email, password);
  }

  @override
  Future<bool> register(String name, String email, String password) async {
    return await firestoreDataSource.register(name, email, password);
  }
}
