import '../../models/attendance/attendance_model.dart';

abstract class IAttendanceRepository {
  Future<List<AttendanceModel>?> getAllAttendance();

  Future<String?> addNewAttendance(AttendanceModel attendance);

  Future<void> updateAttendance(AttendanceModel attendance);

  Future<void> deleteAttendance(String id);

  Future<AttendanceModel?> getAttendanceById(String id);

  Future<List<AttendanceModel>?> getAttendanceByClass(String classId);
}
