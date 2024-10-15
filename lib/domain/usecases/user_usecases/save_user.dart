import '../../../core/entities/user.dart';
import '../../repositories/auth_repository.dart';

class SaveUser {
  final AuthRepository repository;

  SaveUser(this.repository);

  Future<void> call(User user) async {
    await repository.saveUser(user);
  }
}
