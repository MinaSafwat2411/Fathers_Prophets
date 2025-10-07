import 'package:fathers_prophets/data/repositories/eventattendance/event_attendance_repository.dart';

import '../../../data/models/eventattendance/event_attendance_model.dart';

abstract class IEventAttendanceUseCase {

  Future<List<EventAttendanceModel>> getEventAttendance();

  Future<void> addEventAttendance(String uid,String eventId,String event);

  Future<EventAttendanceModel?> getEventAttendanceById(String id);

}