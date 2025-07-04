class AttendanceEventModel {
  final String? userId;
  final String? name;

  AttendanceEventModel({
    this.userId,
    this.name,
});

  factory AttendanceEventModel.fromJson(Map<String, dynamic> json) {
    return AttendanceEventModel(
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