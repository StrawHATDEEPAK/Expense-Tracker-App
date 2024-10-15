import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_expense_tracker/domain/usecases/user_usecases/login_usecase.dart';

import '../../mocks.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const email = 'test@example.com';
  const password = 'password123';

  test('should return true when login is successful', () async {
    // Arrange
    when(mockAuthRepository.login(email, password))
        .thenAnswer((_) async => true);

    // Act
    final result = await loginUseCase.call(email, password);

    // Assert
    expect(result, true);
    verify(mockAuthRepository.login(email, password)).called(1);
  });

  test('should return false when login fails', () async {
    // Arrange
    when(mockAuthRepository.login(email, password))
        .thenAnswer((_) async => false);

    // Act
    final result = await loginUseCase.call(email, password);

    // Assert
    expect(result, false);
    verify(mockAuthRepository.login(email, password)).called(1);
  });
}
