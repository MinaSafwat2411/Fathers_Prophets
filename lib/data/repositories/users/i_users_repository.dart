import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';

import '../../models/users/users_model.dart';

abstract class IUserRepository {
  Future<List<UserModel?>?> getAllServant();

  Future<List<UserModel?>?> getAllUser();

  Future<String?> addNewServant(UserModel servantsModel);

  Future<void> updateUser(UserModel servantsModel);

  Future<void> deleteServant(String id);

  Future<UserModel?> getServantById(String id);

  Future<List<UserModel?>?> getServantsClassId(String id);

  Future<List<UserModel>?> getAllMembers();

  Future<List<UserModel?>?> getAllAdmins();

  Future<String?> addNewMember(UserModel memberModel);

  Future<String?> addNewMemberByDocId(UserModel memberModel);

  Future<void> deleteMember(String id);

  Future<UserModel?> getMemberById(String id);

  Future<List<UserModel?>?> getMembersClassId(String id);

  Future<UserModel?> getUserData(String uid);

  Future<void> updateApply(UserModel user);

  Future<void> addEventAttendance(String uid, String eventId, String event);

  Future<List<UserModel>?> getNotReviewedUsers();

  Future<List<UserModel>?> getReviewedUsers();
}
