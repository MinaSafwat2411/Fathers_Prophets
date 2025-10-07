import 'package:fathers_prophets/domain/usecases/eventattendance/i_event_attendance_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/eventattendance/event_attendance_model.dart';
import '../../../data/repositories/eventattendance/i_event_attendance_repository.dart';

@LazySingleton(as: IEventAttendanceUseCase)
class EventAttendanceUseCase implements IEventAttendanceUseCase{
  final IEventAttendanceRepository repository;

  EventAttendanceUseCase(this.repository);

  @override
  Future<List<EventAttendanceModel>> getEventAttendance() async {
    return await repository.getEventAttendance();
  }

  @override
  Future<void> addEventAttendance(String uid,String eventId,String event)async {
    await repository.addEventAttendance(uid, eventId, event);
  }

  @override
  Future<EventAttendanceModel?> getEventAttendanceById(String id) async {
    return await repository.getEventAttendanceById(id);
  }

}