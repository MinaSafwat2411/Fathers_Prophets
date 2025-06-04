import 'package:fathers_prophets/data/models/users/parents_model.dart';
import 'member_quizzes_model.dart';

class UserModel {
  final String? address;
  final bool? admin;
  final String? classId;
  final String? name;
  final String? phone;
  final String? profile;
  final String? uid;
  final bool? isTeacher;
  final int? age;
  final DateTime? birthday;
  final String? fatherName;
  final bool? isShams;
  final ParentsModel? parents;
  final List<MemberQuizzesModel?>? quizzes;
  final bool? isAdmin;
  final String? date;
  final String? version;
  final bool? isAnyUpdate;


  UserModel({
    this.address,
    this.admin,
    this.classId,
    this.name,
    this.phone,
    this.profile,
    this.uid,
    this.isTeacher,
    this.age,
    this.birthday,
    this.fatherName,
    this.isShams,
    this.parents,
    this.quizzes,
    this.isAdmin,
    this.date,
    this.version,
    this.isAnyUpdate
});
  factory UserModel.fromJson(Map<String, dynamic> json,String uid) {
    return UserModel(
      address: json['address']??"",
      admin: json['admin']??false,
      classId: json['class']??"",
      name: json['name']??"",
      phone: json['phone']??"",
      profile: json['profile']??"",
      uid: uid,
      birthday: DateTime.parse(json['birthday'] ?? ""),
      age: json['age']??-1,
      fatherName: json['fatherName']??"",
      isShams: json['isShams']??false,
      parents:  ParentsModel.fromJson(json['parents']?? <String, dynamic>{
        'fatherPhone': '',
        'motherPhone': '',
      }),
      quizzes: (json['quizzes'] as List<dynamic>?)
          ?.map((e) => MemberQuizzesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isTeacher: json['isTeacher']??false,
      isAdmin: json['isAdmin']??false,
      date: DateTime.parse(json['birthday']).toString(),
      version: json["version"],
      isAnyUpdate: json["isAnyUpdate"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'admin': admin,
      'class': classId,
      'name': name,
      'phone': phone,
      'profile': profile,
      'birthday':  birthday.toString(),
      'age': age,
      'fatherName': fatherName,
      'isShams': isShams,
      'parents': parents?.toJson(),
      'quizzes': quizzes?.map((e) => e?.toJson()).toList()??[],
      'isTeacher':isTeacher,
      'isAdmin':isAdmin,
      'uid':uid,
      "version": version,
      "isAnyUpdate": isAnyUpdate,
    };
  }
  UserModel copyWith({
   String? address,
   bool? admin,
   String? classId,
   String? name,
   String? phone,
   String? profile,
   String? uid,
   bool? isTeacher,
   int? age,
   DateTime? birthday,
   String? fatherName,
   bool? isShams,
   ParentsModel? parents,
   List<MemberQuizzesModel?>? quizzes,
   bool? isAdmin,
   String? date,
   String? version,
   bool? isAnyUpdate
  }){
    return UserModel(
      address: address??this.address,
      admin: admin??this.admin,
      classId: classId??this.classId,
      name: name??this.name,
      phone: phone??this.phone,
      profile: profile??this.profile,
      uid: uid??this.uid,
      isTeacher: isTeacher??this.isTeacher,
      age: age??this.age,
      birthday: birthday??this.birthday,
      fatherName: fatherName??this.fatherName,
      isShams: isShams??this.isShams,
      parents: parents??this.parents,
      quizzes: quizzes??this.quizzes,
      isAdmin: isAdmin??this.isAdmin,
      date: date??this.date,
      version: version??this.version,
      isAnyUpdate: isAnyUpdate??this.isAnyUpdate,
    );
  }

}