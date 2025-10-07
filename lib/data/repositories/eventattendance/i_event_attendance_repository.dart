import '../../models/eventattendance/event_attendance_model.dart';

abstract class IEventAttendanceRepository {
  Future<List<EventAttendanceModel>> getEventAttendance();

  Future<EventAttendanceModel?> getEventAttendanceById(String id);

  Future<void> addEventAttendance(String uid,String eventId,String event);

  Future<void> removeEventAttendance(String uid, String eventId, String event) ;
}