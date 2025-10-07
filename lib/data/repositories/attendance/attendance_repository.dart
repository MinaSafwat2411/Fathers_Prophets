import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/attendance/attendance_model.dart';
import 'package:fathers_prophets/data/repositories/attendance/i_attendance_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAttendanceRepository)
class AttendanceRepository implements IAttendanceRepository {
  @override
  Future<List<AttendanceModel>?> getAllAttendance()async{
    final snapshot =
        await FirebaseFirestore.instance.collection("Attendance").get();
    return snapshot.docs
        .map((doc) => AttendanceModel.fromJson(doc.data(),doc.id))
        .toList();
  }

  @override
  Future<String?> addNewAttendance(AttendanceModel attendance)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.attendance).add(attendance.toJson());
    return snapshot.id;
  }
  @override
  Future<void> updateAttendance(AttendanceModel attendance)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.attendance).doc(attendance.id).update(attendance.toJson());
  }
  @override
  Future<void> deleteAttendance(String id)async{
    await FirebaseFirestore.instance.collection(FirebaseEndpoints.attendance).doc(id).delete();
  }
  @override
  Future<AttendanceModel?> getAttendanceById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.attendance).doc(id).get();
    return AttendanceModel.fromJson(snapshot.data()!,snapshot.id);
  }

  @override
  Future<List<AttendanceModel>?> getAttendanceByClass(String classId)async{
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.attendance).where(FirebaseEndpoints.classId,isEqualTo: classId).get();
    return snapshot.docs
        .map((doc) => AttendanceModel.fromJson(doc.data(),doc.id))
        .toList();
  }

}