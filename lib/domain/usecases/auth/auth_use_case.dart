import 'package:fathers_prophets/data/models/auth/auth_model.dart';

import '../../../data/repositories/auth/auth_repository.dart';




class AuthUseCase {

  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  Future<String?> login(AuthModel authModel) async {
       return await authRepository.login(authModel);
  }

  Future<void> logout() async {
    await authRepository.logout();
  }
}