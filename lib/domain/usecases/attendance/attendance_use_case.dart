import 'package:fathers_prophets/data/models/attendance/attendance_model.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/attendance/i_attendance_repository.dart';
import 'i_attendance_use_case.dart';

@LazySingleton(as: IAttendanceUseCase)
class AttendanceUseCase implements IAttendanceUseCase{
  final IAttendanceRepository repository;

  AttendanceUseCase(this.repository);

  @override
  Future<List<AttendanceModel>> getAllAttendance()async{
    return await repository.getAllAttendance() ?? [];
  }
  @override
  Future<String?> addNewAttendance(AttendanceModel attendance)async{
    return await repository.addNewAttendance(attendance);
  }
  @override
  Future<void> updateAttendance(AttendanceModel attendance)async{
    await repository.updateAttendance(attendance);
  }
  @override
  Future<void> deleteAttendance(String id)async{
    await repository.deleteAttendance(id);
  }
  @override
  Future<AttendanceModel?> getAttendanceById(String id)async {
    return await repository.getAttendanceById(id);
  }
  @override
  Future<List<AttendanceModel>> getAttendanceByClass(String classId)async{
    return await repository.getAttendanceByClass(classId)??[];
  }
}