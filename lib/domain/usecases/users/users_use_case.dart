import 'package:fathers_prophets/data/repositories/users/users_repository.dart';

import '../../../data/models/users/users_model.dart';

class UsersUseCase {
  final UserRepository userRepository;

  UsersUseCase(this.userRepository);

  Future<List<UserModel?>?> getAllServants() async {
    return await userRepository.getAllServant();
  }
  Future<String?> addNewServant(UserModel servantsModel)async{
    return await userRepository.addNewServant(servantsModel);
  }

  Future<void> updateUser(UserModel servantsModel)async{
    await userRepository.updateUser(servantsModel);
  }

  Future<void> deleteServant(String id)async {
    await userRepository.deleteServant(id);
  }

  Future<UserModel?> getServantById(String id)async{
    return await userRepository.getServantById(id);
  }
  Future<List<UserModel?>?> getServantsClassId(String id) async {
    return await userRepository.getServantsClassId(id);
  }
  Future<List<UserModel>?> getAllMembers() async {
    return await userRepository.getAllMembers();
  }
  Future<List<UserModel?>?> getAllAdmins() async {
    return await userRepository.getAllAdmins();
  }
  Future<String?> addNewMember(UserModel memberModel)async {
    return await userRepository.addNewMember(memberModel);
  }
  Future<void> deleteMember(String id)async {
    await userRepository.deleteMember(id);
  }
  Future<UserModel?> getMemberById(String id)async{
    return await userRepository.getMemberById(id);
  }
  Future<List<UserModel?>?> getMembersClassId(String id) async {
    return await userRepository.getMembersClassId(id);
  }

  Future<UserModel?> getUserData(String uid)async{
    return await userRepository.getUserData(uid);
  }
  Future<void> updateApply(UserModel user)async{
    await userRepository.updateApply(user);
  }
  Future<void> updateApplyToAll(List<UserModel> users)async {
    await userRepository.updateApplyToAll(users);
  }
  Future<void> addEventAttendance(String uid,String eventId,String title)async{
    await userRepository.addEventAttendance(uid,eventId,title);
  }
}