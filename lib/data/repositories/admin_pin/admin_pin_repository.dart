import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:injectable/injectable.dart';

import '../../models/admin_pin/admin_pin_model.dart';
import 'i_admin_pin_repository.dart';

@LazySingleton(as: IAdminPinRepository)
class AdminPinRepository implements IAdminPinRepository {
  @override
  Future<bool> checkAdminPin(AdminPinModel pin) async {
    try{
      final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.adminPin).where(FirebaseEndpoints.version).get();
      if (snapshot.docs.isNotEmpty) {
        final adminPin = AdminPinModel.fromJson(snapshot.docs.first.data());
        return adminPin.pin == pin.pin;
      }else {
        return false;
      }
    } on SocketException {
      return false;
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }
}