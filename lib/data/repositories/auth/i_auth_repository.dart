import '../../models/auth/auth_model.dart';

abstract class IAuthRepository {
  Future<String?> login(AuthModel login);
  Future<void> logout();
  Future<String> register(AuthModel login);
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