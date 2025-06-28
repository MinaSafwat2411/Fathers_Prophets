import 'event_attendance_model.dart';

class EventsModel {
  final String? nameAr;
  final String? nameEn;
  final String? title;
  final String? image;
  final String? date;
  final String? docId;
  DateTime? dateTime;

  EventsModel({
    this.nameAr,
    this.nameEn,
    this.title,
    this.image,
    this.date,
    this.docId,
    this.dateTime,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json, String id,String nameEn) {
    return EventsModel(
      nameAr: json['name'],
      title: json['title'],
      image: json['image'],
      date: json['date'],
      docId: id,
      dateTime: DateTime.parse(json['date']),
      nameEn: nameEn,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': nameAr,
      'title': title,
      'image': image,
      'date': date,
      'docId': docId,
    };
  }

  EventsModel copyWith({
    String? name,
    String? title,
    String? image,
    String? date,
    String? docId,
    DateTime? dateTime,
    String? nameEn,
    List<EventAttendanceModel>? attendance,
  }) {
    return EventsModel(
      date: date ?? this.date,
      docId: docId ?? this.docId,
      nameAr: name ?? nameAr,
      dateTime: dateTime ?? this.dateTime,
      image: image ?? this.image,
      title: title ?? this.title,
      nameEn: nameEn ?? this.nameEn,
    );
  }
}
