import 'package:injectable/injectable.dart';

import '../../../data/models/users/users_model.dart';
import '../../../data/repositories/users/i_users_repository.dart';
import 'i_users_use_case.dart';

@LazySingleton(as: IUsersUseCase)
class UsersUseCase implements IUsersUseCase{
  final IUserRepository userRepository;

  UsersUseCase(this.userRepository);

  @override
  Future<List<UserModel?>?> getAllServants() async {
    return await userRepository.getAllServant();
  }
  @override
  Future<String?> addNewServant(UserModel servantsModel)async{
    return await userRepository.addNewServant(servantsModel);
  }

  @override
  Future<void> updateUser(UserModel servantsModel)async{
    await userRepository.updateUser(servantsModel);
  }

  @override
  Future<void> deleteServant(String id)async {
    await userRepository.deleteServant(id);
  }

  @override
  Future<UserModel?> getServantById(String id)async{
    return await userRepository.getServantById(id);
  }
  @override
  Future<List<UserModel?>?> getServantsClassId(String id) async {
    return await userRepository.getServantsClassId(id);
  }
  @override
  Future<List<UserModel>?> getAllMembers() async {
    return await userRepository.getAllMembers();
  }
  @override
  Future<List<UserModel?>?> getAllAdmins() async {
    return await userRepository.getAllAdmins();
  }
  @override
  Future<String?> addNewMember(UserModel memberModel)async {
    return await userRepository.addNewMember(memberModel);
  }
  @override
  Future<String?> addNewMemberByDocId(UserModel memberModel)async {
    return await userRepository.addNewMemberByDocId(memberModel);
  }
  @override
  Future<void> deleteMember(String id)async {
    await userRepository.deleteMember(id);
  }
  @override
  Future<UserModel?> getMemberById(String id)async{
    return await userRepository.getMemberById(id);
  }
  @override
  Future<List<UserModel?>?> getMembersClassId(String id) async {
    return await userRepository.getMembersClassId(id);
  }

  @override
  Future<UserModel?> getUserData(String uid)async{
    return await userRepository.getUserData(uid);
  }
  @override
  Future<void> updateApply(UserModel user)async{
    await userRepository.updateApply(user);
  }
  @override
  Future<void> addEventAttendance(String uid,String eventId,String title)async{
    await userRepository.addEventAttendance(uid,eventId,title);
  }
  @override
  Future<List<UserModel>?> getNotReviewedUsers() async {
    return await userRepository.getNotReviewedUsers();
  }
  @override
  Future<List<UserModel>?> getReviewedUsers() async {
    return await userRepository.getReviewedUsers();
  }
}