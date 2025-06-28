class EventAttendanceModel {
  final String? userId;
  final String? name;

  EventAttendanceModel({
    this.userId,
    this.name,
});

  factory EventAttendanceModel.fromJson(Map<String, dynamic> json) {
    return EventAttendanceModel(
      userId: json['userId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
    };
  }
}