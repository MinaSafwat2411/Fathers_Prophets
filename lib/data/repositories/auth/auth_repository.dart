
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/auth/auth_model.dart';
import '../../services/cache_helper.dart';


class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;

  Future<String?> login(AuthModel login) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: login.email,
        password: login.password,
      );
      await CacheHelper.saveData(key: 'uid', value:  response.user?.uid);
      return response.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<String> register(AuthModel login) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: login.email,
        password: login.password,
      );
      return response.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      return currentUser != null;
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<String> getCurrentUserId() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      return currentUser?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<String> getCurrentUserEmail() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      return currentUser?.email ?? '';
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        // ignore: deprecated_member_use
        await currentUser.updateEmail(newEmail);
      }
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> deleteAccount() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.delete();
      }
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }
  Future<bool> isEmailVerified() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        return currentUser.emailVerified;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      throw extractFirebaseAuthError(e);
    } catch (e) {
      throw "An unexpected error occurred. Please try again.";
    }
  }

  String extractFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "The email address is not valid.";
      case 'user-disabled':
        return "This user account has been disabled.";
      case 'user-not-found':
        return "No user found for this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      case 'too-many-requests':
        return "We have blocked all requests from this device due to unusual activity. Try again later.";
      case 'network-request-failed':
        return "No internet connection. Please check your network.";
      default:
        return "Authentication failed. Please try again.";
    }
  }
}