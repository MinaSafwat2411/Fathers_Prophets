import 'package:fathers_prophets/data/models/attendance/attendance_model.dart';
import 'package:fathers_prophets/data/repositories/attendance/attendance_repository.dart';

abstract class IAttendanceUseCase {

  Future<List<AttendanceModel>> getAllAttendance();
  Future<String?> addNewAttendance(AttendanceModel attendance);
  Future<void> updateAttendance(AttendanceModel attendance);
  Future<void> deleteAttendance(String id);
  Future<AttendanceModel?> getAttendanceById(String id);
  Future<List<AttendanceModel>> getAttendanceByClass(String classId);
}