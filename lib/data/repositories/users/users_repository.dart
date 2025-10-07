import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/repositories/users/i_users_repository.dart';
import 'package:injectable/injectable.dart';

import '../../models/users/users_model.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  @override
  Future<List<UserModel?>?> getAllServant()async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isTeacher,isEqualTo: true).get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data(),doc.id)).toList();
  }
  @override
  Future<List<UserModel?>?> getAllUser()async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data(),doc.id)).toList();
  }
  @override
  Future<String?> addNewServant(UserModel servantsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).add(servantsModel.toJson());
    return snapshot.id;
  }
  @override
  Future<void> updateUser(UserModel servantsModel)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(servantsModel.uid).update(servantsModel.toJson());
  }

  @override
  Future<void> deleteServant(String id)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).delete();
  }
  @override
  Future<UserModel?> getServantById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).get();
    return UserModel.fromJson(snapshot.data()!,snapshot.id);
  }
  @override
  Future<List<UserModel?>?> getServantsClassId(String id) async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isTeacher,isEqualTo: true).where(FirebaseEndpoints.classId,isEqualTo: id).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  @override
  Future<List<UserModel>?> getAllMembers() async {
    final snapshot =
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isTeacher,isEqualTo: false).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  @override
  Future<List<UserModel?>?> getAllAdmins() async {
    final snapshot =
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isAdmin,isEqualTo: true).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<String?> addNewMember(UserModel memberModel)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(memberModel.uid).set(memberModel.toJson());
    return memberModel.uid;
  }
  @override
  Future<String?> addNewMemberByDocId(UserModel memberModel)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).add(memberModel.toJson());
    return  snapshot.id;
  }
  @override
  Future<void> deleteMember(String id)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).delete();
  }

  @override
  Future<UserModel?> getMemberById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(id).get();
    return UserModel.fromJson(snapshot.data()!,snapshot.id);
  }
  @override
  Future<List<UserModel?>?> getMembersClassId(String id) async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.classId,isEqualTo: id).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  @override
  Future<UserModel?> getUserData(String uid)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(uid).get();
    return UserModel.fromJson(snapshot.data()!,snapshot.id);
  }

  @override
  Future<void> updateApply(UserModel user)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(user.uid).update(user.toJson());
  }
  @override
  Future<void> addEventAttendance(String uid,String eventId,String event)async{
    if(uid.isNotEmpty) {
      await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).doc(uid).update({
      event: FieldValue.arrayUnion([eventId])
    });
    }
  }

  @override
  Future<List<UserModel>?> getNotReviewedUsers() async {
    final snapshot =
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isReviewed,isEqualTo: false).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<UserModel>?> getReviewedUsers() async {
    final snapshot =
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.users).where(FirebaseEndpoints.isReviewed,isEqualTo: true).get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id)).toList();
  }
}