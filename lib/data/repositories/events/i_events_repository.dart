import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';

abstract class IEventsRepository {
  Future<List<EventsModel>?> getEventsByName(String event);

  Future<String?> addNewEventByName(EventsModel eventsModel, String event);

  Future<void> addEventAttendance(
    List<String> attendance,
    String eventId,
    String event,
  );

  Future<void> removeEventAttendance(
    List<String> attendance,
    String eventId,
    String event,
  );
}
