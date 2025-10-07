import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:injectable/injectable.dart';

import 'i_events_repository.dart';

@LazySingleton(as: IEventsRepository)
class EventsRepository implements IEventsRepository{
  @override
  Future<List<EventsModel>?> getEventsByName(String event) async {
    final snapshot =
    await FirebaseFirestore.instance.collection(event).get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      return snapshot.docs
          .map(
            (doc) =>
            EventsModel.fromJson(doc.data(), doc.id, FirebaseEndpoints.pingPong != event ? event.toLowerCase() : FirebaseEndpoints.pingpong),
      )
          .toList();
    }
  }

  @override
  Future<String?> addNewEventByName(EventsModel eventsModel,String event) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(event)
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  @override
  Future<void> addEventAttendance(
      List<String> attendance,
      String eventId,
      String event
      ) async {
    await FirebaseFirestore.instance.collection(event).doc(eventId).update(
      {FirebaseEndpoints.attendance.toLowerCase(): FieldValue.arrayUnion(attendance)},
    );
  }

  @override
  Future<void> removeEventAttendance(
      List<String> attendance,
      String eventId,
      String event
      ) async {
    await FirebaseFirestore.instance.collection(event).doc(eventId).update({
      FirebaseEndpoints.attendance.toLowerCase(): FieldValue.arrayRemove(attendance),
    });
  }

}
