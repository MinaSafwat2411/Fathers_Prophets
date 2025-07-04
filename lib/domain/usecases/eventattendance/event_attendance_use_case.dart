import 'package:fathers_prophets/data/repositories/eventattendance/event_attendance_repository.dart';

import '../../../data/models/eventattendance/event_attendance_model.dart';

class EventAttendanceUseCase {
  final EventAttendanceRepository repository;

  EventAttendanceUseCase(this.repository);

  Future<List<EventAttendanceModel>> getEventAttendance() async {
    return await repository.getEventAttendance();
  }

  Future<void> addEventAttendance(String uid,String eventId,String event)async {
    await repository.addEventAttendance(uid, eventId, event);
  }

  Future<EventAttendanceModel?> getEventAttendanceById(String id) async {
    return await repository.getEventAttendanceById(id);
  }

}