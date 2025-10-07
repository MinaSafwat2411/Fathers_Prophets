import 'package:fathers_prophets/data/repositories/users/users_repository.dart';

import '../../../data/models/users/users_model.dart';

abstract class IUsersUseCase {
  Future<List<UserModel?>?> getAllServants();

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

  Future<void> addEventAttendance(String uid, String eventId, String title);

  Future<List<UserModel>?> getNotReviewedUsers();

  Future<List<UserModel>?> getReviewedUsers();
}
