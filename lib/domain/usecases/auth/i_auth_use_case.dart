import '../../../data/models/auth/auth_model.dart';

abstract class IAuthUseCase {
  Future<String?> login(AuthModel authModel);
  Future<void> logout();
  Future<String> register(AuthModel authModel);
  Future<bool> isLoggedIn();
  Future<String> getCurrentUserId();
  Future<String> getCurrentUserEmail();
  Future<void> updatePassword(String newPassword);
  Future<void> updateEmail(String newEmail);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}