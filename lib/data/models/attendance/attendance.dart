class Attendance{
  bool? odas;
  bool? tnawel;
  bool? shmas;
  bool? sundaySchool;
  final String? uid;
  final String? name;

  Attendance({
    this.name,
    this.uid,
    this.odas,
    this.shmas,
    this.sundaySchool,
    this.tnawel
});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      name: json['name'],
      uid: json['uid'],
      odas: json['odas'],
      shmas: json['shmas'],
      tnawel: json['tnawel'],
      sundaySchool: json['sundaySchool'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'odas': odas,
      'shmas': shmas,
      'tnawel': tnawel,
      'sundaySchool': sundaySchool,
    };
  }
}