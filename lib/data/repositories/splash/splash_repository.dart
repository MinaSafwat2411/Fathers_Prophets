import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/splash/splash_model.dart';
import 'package:injectable/injectable.dart';

import 'i_splash_repository.dart';

@LazySingleton(as: ISplashRepository)
class SplashRepository implements ISplashRepository{

  @override
  Future<SplashModel?> getRequireToUpdate() async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.splash).doc(FirebaseEndpoints.version).get();
    if (snapshot.exists) {
      return SplashModel.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}