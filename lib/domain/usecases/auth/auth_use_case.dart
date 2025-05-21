import 'package:fathers_prophets/data/models/auth/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<String> register(AuthModel authModel) async {
    return await authRepository.register(authModel);
  }
  Future<bool> isLoggedIn() async {
    return await authRepository.isLoggedIn();
  }
  Future<String> getCurrentUserId() async {
    return await authRepository.getCurrentUserId();
  }
  Future<String> getCurrentUserEmail() async {
    return await authRepository.getCurrentUserEmail();
  }
  Future<void> updatePassword(String newPassword) async {
    await authRepository.updatePassword(newPassword);
  }
  Future<void> updateEmail(String newEmail) async {
    await authRepository.updateEmail(newEmail);
  }
  Future<void> sendPasswordResetEmail(String email) async {
    await authRepository.sendPasswordResetEmail(email);
  }
  Future<void> deleteAccount() async {
    await authRepository.deleteAccount();
  }
  Future<void> sendEmailVerification() async {
    await authRepository.sendEmailVerification();
  }
  Future<bool> isEmailVerified() async {
    return await authRepository.isEmailVerified();
  }
  String extractFirebaseAuthError(FirebaseAuthException e) {
    return authRepository.extractFirebaseAuthError(e);
  }
}