import 'package:fathers_prophets/data/repositories/events/events_repository.dart';

import '../../../data/models/events/events_model.dart';

abstract class IEventsUseCase {
  Future<String> addNewEventByName(EventsModel eventsModel,String event);

  Future<void> addEventAttendance(List<String> attendance, String eventId, String event);

  Future<List<EventsModel>> getEventsByName(String event);

}