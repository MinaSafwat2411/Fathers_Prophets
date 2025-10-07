import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/splash/splash_model.dart';

abstract class ISplashRepository {
  Future<SplashModel?> getRequireToUpdate();
}