import 'package:fathers_prophets/data/models/attendance/attendance_model.dart';
import 'package:fathers_prophets/data/repositories/attendance/attendance_repository.dart';

class AttendanceUseCase {
  final AttendanceRepository repository;

  AttendanceUseCase(this.repository);

  Future<List<AttendanceModel>> getAllAttendance()async{
    return await repository.getAllAttendance() ?? [];
  }
  Future<String?> addNewAttendance(AttendanceModel attendance)async{
    return await repository.addNewAttendance(attendance);
  }
  Future<void> updateAttendance(AttendanceModel attendance)async{
    await repository.updateAttendance(attendance);
  }
  Future<void> deleteAttendance(String id)async{
    await repository.deleteAttendance(id);
  }
  Future<AttendanceModel?> getAttendanceById(String id)async {
    return await repository.getAttendanceById(id);
  }
  Future<List<AttendanceModel>> getAttendanceByClass(String classId)async{
    return await repository.getAttendanceByClass(classId)??[];
  }
}