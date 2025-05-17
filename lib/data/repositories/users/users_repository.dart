import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';

import '../../models/users/users_model.dart';

class UserRepository {
  Future<List<UserModel?>?> getAllServant()async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isTeacher,isEqualTo: true).get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data(),doc.id)).toList();
  }
  Future<List<UserModel?>?> getAllUser()async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data(),doc.id)).toList();
  }
  Future<String?> addNewServant(UserModel servantsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).add(servantsModel.toJson());
    return snapshot.id;
  }
  Future<void> updateUser(UserModel servantsModel)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(servantsModel.uid).update(servantsModel.toJson());
  }

  Future<void> deleteServant(String id)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).delete();
  }
  Future<UserModel?> getServantById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).get();
    return UserModel.fromJson(snapshot.data()!,snapshot.id);
  }
  Future<List<UserModel?>?> getServantsClassId(String id) async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isTeacher,isEqualTo: true).where(FirebaseEndpoints.classId,isEqualTo: id).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  Future<List<UserModel?>?> getAllMembers() async {
    final snapshot =
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isTeacher,isEqualTo: false).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<String?> addNewMember(UserModel memberModel)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).add(memberModel.toJson());
    return snapshot.id;
  }
  Future<void> deleteMember(String id)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).delete();
  }

  Future<UserModel?> getMemberById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).get();
    return UserModel.fromJson(snapshot.data()!,snapshot.id);
  }
  Future<List<UserModel?>?> getMembersClassId(String id) async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.classId,isEqualTo: id).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  Future<UserModel?> getUserData(String uid)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(uid).get();
    return UserModel.fromJson(snapshot.data()!,snapshot.id);
  }

  Future<void> updateApply(UserModel user)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(user.uid).update(user.toJson());
  }
  Future<void> updateApplyToAll()async{
    var users = await getAllUser();
    for(var user in users?? <UserModel>[]){
      await updateUser(user??UserModel());
    }
  }
}