import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';

abstract class IClassRepository {
  Future<List<ClassModel>?> getAllClasses();

  Future<String?> addNewClass(ClassModel classModel);

  Future<void> updateClass(ClassModel classModel);

  Future<void> removeMember(ClassModel classModel, ClassUserModel member);

  Future<void> deleteClass(String id);

  Future<ClassModel?> getClassById(String id);
}
