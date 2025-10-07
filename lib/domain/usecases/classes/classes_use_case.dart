import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/domain/usecases/classes/i_classes_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/classes/class_model.dart';
import '../../../data/repositories/classes/i_class_repository.dart';

@LazySingleton(as: IClassesUseCase)
class ClassesUseCase implements IClassesUseCase {
  final IClassRepository classRepository;

  ClassesUseCase(this.classRepository);

  @override
  Future<List<ClassModel>> getAllClasses() async {
    return await classRepository.getAllClasses()??[];
  }

  @override
  Future<String?> addNewClass(ClassModel classModel)async{
    return await classRepository.addNewClass(classModel);
  }

  @override
  Future<void> updateClass(ClassModel classModel)async{
    await classRepository.updateClass(classModel);
  }

  @override
  Future<void> removerMember(ClassModel classModel,ClassUserModel member)async{
    await classRepository.removeMember(classModel, member);
  }
  @override
  Future<void> deleteClass(String id)async {
    await classRepository.deleteClass(id);
  }
  @override
  Future<ClassModel?> getClassById(String id)async{
    return await classRepository.getClassById(id);
  }
}