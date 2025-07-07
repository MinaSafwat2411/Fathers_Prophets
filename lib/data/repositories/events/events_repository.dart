import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';

class EventsRepository {
  Future<List<EventsModel>?> getFootballEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Football").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'football', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getVolleyballEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Volleyball").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'volleyball', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getBibleEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Bible").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) => EventsModel.fromJson(doc.data(), doc.id, 'bible', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getRitualEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Ritual").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'ritual', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getDoctrineEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Doctrine").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'doctrine', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getCopticEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Coptic").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'coptic', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getChoirEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Choir").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) => EventsModel.fromJson(doc.data(), doc.id, 'choir', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getChessEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Chess").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) => EventsModel.fromJson(doc.data(), doc.id, 'chess', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getPingPongEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("PingPong").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'pingPong', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getMelodiesEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Melodies").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'melodies', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getPrayEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Pray").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) => EventsModel.fromJson(doc.data(), doc.id, 'pray', index++),
          )
          .toList();
    }
  }

  Future<List<EventsModel>?> getPraiseEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Praise").get();
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      var index = -1;
      return snapshot.docs
          .map(
            (doc) =>
                EventsModel.fromJson(doc.data(), doc.id, 'praise', index++),
          )
          .toList();
    }
  }

  Future<String?> addNewFootballEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Football")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewVolleyballEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Volleyball")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewBibleEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Bible")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewRitualEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Ritual")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewDoctrineEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Doctrine")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewCopticEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Coptic")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewChoirEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Choir")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewChessEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Chess")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewPingPongEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("PingPong")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewMelodiesEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Melodies")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewPrayEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Pray")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewPraiseEvent(EventsModel eventsModel) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Praise")
        .add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<void> addFootballAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Football").doc(eventId).update(
      {"attendance": FieldValue.arrayUnion(attendance)},
    );
  }

  Future<void> addVolleyballAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance
        .collection("Volleyball")
        .doc(eventId)
        .update({"attendance": FieldValue.arrayUnion(attendance)});
  }

  Future<void> addBibleAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Bible").doc(eventId).update({
      "attendance": FieldValue.arrayUnion(attendance),
    });
  }

  Future<void> addRitualAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Ritual").doc(eventId).update({
      "attendance": FieldValue.arrayUnion(attendance),
    });
  }

  Future<void> addDoctrineAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Doctrine").doc(eventId).update(
      {"attendance": FieldValue.arrayUnion(attendance)},
    );
  }

  Future<void> addCopticAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Coptic").doc(eventId).update({
      "attendance": FieldValue.arrayUnion(attendance),
    });
  }

  Future<void> addChoirAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Choir").doc(eventId).update({
      "attendance": FieldValue.arrayUnion(attendance),
    });
  }

  Future<void> addChessAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Chess").doc(eventId).update({
      "attendance": FieldValue.arrayUnion(attendance),
    });
  }

  Future<void> addPingPongAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("PingPong").doc(eventId).update(
      {"attendance": FieldValue.arrayUnion(attendance)},
    );
  }

  Future<void> addMelodiesAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Melodies").doc(eventId).update(
      {"attendance": FieldValue.arrayUnion(attendance)},
    );
  }

  Future<void> addPrayAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Pray").doc(eventId).update({
      "attendance": FieldValue.arrayUnion(attendance),
    });
  }

  Future<void> addPraiseAttendance(
    List<String> attendance,
    String eventId,
  ) async {
    await FirebaseFirestore.instance.collection("Praise").doc(eventId).update({
      "attendance": FieldValue.arrayUnion(attendance),
    });
  }
}
