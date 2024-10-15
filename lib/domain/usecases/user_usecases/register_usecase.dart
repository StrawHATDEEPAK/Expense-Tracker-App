import '../../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase({required this.repository});
  Future<void> call(String name, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email or password cannot be empty");
    }

    try {
      await repository.register(name, email, password);
    } catch (e) {
      throw Exception("Signup failed: ${e.toString()}");
    }
  }
}
