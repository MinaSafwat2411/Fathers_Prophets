import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/data/models/auth/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'i_remote_data_source.dart';

@LazySingleton(as: IRemoteDataSource)
class RemoteDataSource implements IRemoteDataSource{

  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<String?> login(AuthModel login) async{
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: login.email,
        password: login.password,
      );
      return response.user?.uid;
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