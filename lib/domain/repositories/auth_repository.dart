import '../../core/entities/user.dart';

abstract class AuthRepository {
  Future<void> saveUser(User user);
  Future<User?> getUser();

  Future<void> logout();
  Future<bool> login(String email, String password);
  Future<bool> register(String name, String email, String password);
}
