import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/data/repositories/classes/class_repository.dart';

import '../../../data/models/classes/class_model.dart';

abstract class IClassesUseCase {
  Future<List<ClassModel>> getAllClasses();

  Future<String?> addNewClass(ClassModel classModel);

  Future<void> updateClass(ClassModel classModel);

  Future<void> removerMember(ClassModel classModel, ClassUserModel member);

  Future<void> deleteClass(String id);

  Future<ClassModel?> getClassById(String id);
}
