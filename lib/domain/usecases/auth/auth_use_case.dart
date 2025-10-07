import 'package:fathers_prophets/data/models/auth/auth_model.dart';
import 'package:fathers_prophets/domain/usecases/auth/i_auth_use_case.dart';
import 'package:injectable/injectable.dart';
import '../../../data/repositories/auth/i_auth_repository.dart';

@LazySingleton(as: IAuthUseCase)
class AuthUseCase implements IAuthUseCase {

  final IAuthRepository authRepository;

  AuthUseCase(this.authRepository);

  @override
  Future<String?> login(AuthModel authModel) async {
       return await authRepository.login(authModel);
  }

  @override
  Future<void> logout() async {
    await authRepository.logout();
  }
  @override
  Future<String> register(AuthModel authModel) async {
    return await authRepository.register(authModel);
  }
  @override
  Future<bool> isLoggedIn() async {
    return await authRepository.isLoggedIn();
  }
  @override
  Future<String> getCurrentUserId() async {
    return await authRepository.getCurrentUserId();
  }
  @override
  Future<String> getCurrentUserEmail() async {
    return await authRepository.getCurrentUserEmail();
  }
  @override
  Future<void> updatePassword(String newPassword) async {
    await authRepository.updatePassword(newPassword);
  }
  @override
  Future<void> updateEmail(String newEmail) async {
    await authRepository.updateEmail(newEmail);
  }
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await authRepository.sendPasswordResetEmail(email);
  }
  @override
  Future<void> deleteAccount() async {
    await authRepository.deleteAccount();
  }
  @override
  Future<void> sendEmailVerification() async {
    await authRepository.sendEmailVerification();
  }
  @override
  Future<bool> isEmailVerified() async {
    return await authRepository.isEmailVerified();
  }
}