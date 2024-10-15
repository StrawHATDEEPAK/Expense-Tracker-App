import '../../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email or password cannot be empty");
    }

    try {
      return await repository.login(email, password);
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }
}
