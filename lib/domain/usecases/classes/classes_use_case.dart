import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/data/repositories/classes/class_repository.dart';

import '../../../data/models/classes/class_model.dart';

class ClassesUseCase {
  final ClassRepository classRepository;

  ClassesUseCase(this.classRepository);

  Future<List<ClassModel>> getAllClasses() async {
    return await classRepository.getAllClasses()??[];
  }

  Future<String?> addNewClass(ClassModel classModel)async{
    return await classRepository.addNewClass(classModel);
  }

  Future<void> updateClass(ClassModel classModel)async{
    await classRepository.updateClass(classModel);
  }

  Future<void> removerMember(ClassModel classModel,ClassUserModel member)async{
    await classRepository.removeMember(classModel, member);
  }
  Future<void> deleteClass(String id)async {
    await classRepository.deleteClass(id);
  }
  Future<ClassModel?> getClassById(String id)async{
    return await classRepository.getClassById(id);
  }
}