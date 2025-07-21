import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';

class ClassRepository {
  Future<List<ClassModel>?> getAllClasses() async {
    final snapshot =
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.classes).get();
    return snapshot.docs
        .map((doc) => ClassModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  Future<String?> addNewClass(ClassModel classModel)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.classes).add(classModel.toJson());
    return snapshot.id;
  }
  Future<void> updateClass(ClassModel classModel) async {
    final members = <Map<String, dynamic>>[];
    final servants = <Map<String, dynamic>>[];

    for (var member in classModel.members ?? []) {
      final userMap = {
        'name': member.name,
        'uid': member.uid,
        'isTeacher': member.isTeacher ?? false,
      };

      if (member.isTeacher ?? false) {
        servants.add(userMap);
      } else {
        members.add(userMap);
      }
    }

    for (var member in classModel.servants ?? []) {
      final userMap = {
        'name': member.name,
        'uid': member.uid,
        'isTeacher': member.isTeacher ?? false,
      };

      if (member.isTeacher ?? false) {
        servants.add(userMap);
      } else {
        members.add(userMap);
      }
    }

    await FirebaseFirestore.instance
        .collection(FirebaseEndpoints.classes)
        .doc(classModel.docId)
        .set({
      'members': members,
      'servants': servants,
      'name': classModel.name,
      'docId': classModel.docId,
    }, SetOptions(merge: true));
  }
  Future<void> removeMember(ClassModel classModel, ClassUserModel member) async {
    final userMap = {
      'name': member.name,
      'uid': member.uid,
    };

    final fieldToUpdate = (member.isTeacher ?? false) ? 'servants' : 'members';

    await FirebaseFirestore.instance
        .collection(FirebaseEndpoints.classes)
        .doc(classModel.docId)
        .set({
      fieldToUpdate: FieldValue.arrayRemove([userMap])
    }, SetOptions(merge: true));
  }

  Future<void> deleteClass(String id)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.classes).doc(id).delete();
  }

  Future<ClassModel?> getClassById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.classes).doc(id).get();
    return ClassModel.fromJson(snapshot.data()!,snapshot.id);
  }
}