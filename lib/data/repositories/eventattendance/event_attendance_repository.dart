import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:injectable/injectable.dart';

import '../../models/eventattendance/event_attendance_model.dart';
import 'i_event_attendance_repository.dart';

@LazySingleton(as: IEventAttendanceRepository)
class EventAttendanceRepository implements IEventAttendanceRepository{
  @override
  Future<List<EventAttendanceModel>> getEventAttendance() async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.eventAttendance).get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventAttendanceModel.fromJson(doc.data())).toList();
    }
  }

  @override
  Future<EventAttendanceModel?> getEventAttendanceById(String id) async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.eventAttendance).doc(id).get();
    if(snapshot.exists){
      return EventAttendanceModel.fromJson(snapshot.data()!);
    }else {
      return null;
    }
  }

  @override
  Future<void> addEventAttendance(String uid,String eventId,String event)async {
    if (uid.isNotEmpty) {
      await FirebaseFirestore.instance.collection(FirebaseEndpoints.eventAttendance).doc(uid).set({
        event: FieldValue.arrayUnion([eventId]),
      },SetOptions(merge: true));
    }
  }

  @override
  Future<void> removeEventAttendance(String uid, String eventId, String event) async {
    if (uid.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection(FirebaseEndpoints.eventAttendance)
          .doc(uid)
          .set({
        event: FieldValue.arrayRemove([eventId]),
      }, SetOptions(merge: true));
    }
  }

}