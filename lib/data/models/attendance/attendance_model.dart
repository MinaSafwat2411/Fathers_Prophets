import 'package:cloud_firestore/cloud_firestore.dart';

import 'attendance.dart';

class AttendanceModel {
  final DateTime? date;
  final List<Attendance?>? attendance;
  final String? id;
  final String? classId;
  String? dateView;

  AttendanceModel({
    this.attendance,
    this.date,
    this.id,
    this.dateView,
    this.classId,
});

  factory AttendanceModel.fromJson(Map<String, dynamic> json,String id) {
    return AttendanceModel(
      date: (json['date']as Timestamp?)?.toDate(),
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: id,
      classId: json['class']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'attendance': attendance?.map((e) => e?.toJson()).toList(),
      'class': classId,
    };
  }

  AttendanceModel copyWith({
    DateTime? date,
    List<Attendance?>? attendance,
    String? id,
    String? classId,
    String? dateView,
}){
    return AttendanceModel(
      date: date ?? this.date,
      attendance: attendance ?? this.attendance,
      id: id ?? this.id,
      classId: classId ?? this.classId,
      dateView: dateView ?? this.dateView,
    );
  }

}

