import 'member_quizzes_model.dart';

class UserModel {
  // final String? address;
  // final String? phone;
  // final int? age;
  // final String? birthday;
  // DateTime? birthdayDate;
  // final String? fatherName;
  // final bool? isShams;
  // final ParentsModel? parents;
  final String? classId;
  final String? name;
  final String? profile;
  final String? uid;
  final bool? isTeacher;
  final List<MemberQuizzesModel?>? quizzes;
  final bool? isAdmin;
  final String? version;
  final bool? isAnyUpdate;
  final List<String>? football;
  final List<String>? volleyball;
  final List<String>? pingPong;
  final List<String>? chess;
  final List<String>? melodies;
  final List<String>? choir;
  final List<String>? ritual;
  final List<String>? coptic;
  final List<String>? doctrine;
  final List<String>? bible;
  final bool? isReviewed;
  bool? checked;


  UserModel({
    // this.address,
    // this.phone,
    // this.age,
    // this.birthday,
    // this.fatherName,
    // this.isShams,
    // this.parents,
    // this.birthdayDate,
    this.classId,
    this.name,
    this.profile,
    this.uid,
    this.isTeacher,
    this.quizzes,
    this.isAdmin,
    this.version,
    this.isAnyUpdate,
    this.football,
    this.volleyball,
    this.pingPong,
    this.chess,
    this.melodies,
    this.choir,
    this.ritual,
    this.coptic,
    this.doctrine,
    this.bible,
    this.checked,
    this.isReviewed,
});
  factory UserModel.fromJson(Map<String, dynamic> json,String uid) {
    return UserModel(
      // address: json['address']??"",
      // phone: json['phone']??"",
      // birthday: json['birthday']??"",
      // birthdayDate: json['birthday'] != null ? DateTime.tryParse(json['birthday']) : DateTime.now(),
      // age: json['age']??-1,
      // fatherName: json['fatherName']??"",
      // isShams: json['isShams']??false,
      // parents:  ParentsModel.fromJson(json['parents']?? <String, dynamic>{
      //   'fatherPhone': '',
      //   'motherPhone': '',
      // }),
      classId: json['class']??"",
      name: json['name']??"",
      profile: json['profile']??"",
      uid: uid,
      quizzes: (json['quizzes'] as List<dynamic>?)
          ?.map((e) => MemberQuizzesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isTeacher: json['isTeacher']??false,
      isAdmin: json['isAdmin']??false,
      version: json["version"]??"",
      isAnyUpdate: json["isAnyUpdate"]??false,
      football: (json["football"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      volleyball: (json["volleyball"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      pingPong: (json["pingPong"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      chess: (json["chess"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      melodies: (json["melodies"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      choir: (json["choir"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      ritual: (json["ritual"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      coptic: (json["coptic"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      doctrine: (json["doctrine"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      bible: (json["bible"]as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      checked: false,
      isReviewed: json['isReviewed']??false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      // 'address': address,
      // 'phone': phone,
      // 'birthday':  birthday,
      // 'age': age,
      // 'fatherName': fatherName,
      // 'isShams': isShams,
      // 'parents': parents?.toJson(),
      'class': classId,
      'name': name,
      'profile': profile,
      'quizzes': quizzes?.map((e) => e?.toJson()).toList()??[],
      'isTeacher':isTeacher,
      'isAdmin':isAdmin,
      'uid':uid,
      "version": version,
      "isAnyUpdate": isAnyUpdate,
      "football": football?.map((e) => e).toList(),
      "volleyball": volleyball?.map((e) => e).toList(),
      "pingPong": pingPong?.map((e) => e).toList(),
      "chess": chess?.map((e) => e).toList(),
      "melodies": melodies?.map((e) => e).toList(),
      "choir": choir?.map((e) => e).toList(),
      "ritual": ritual?.map((e) => e).toList(),
      "coptic": coptic?.map((e) => e).toList(),
      "doctrine": doctrine?.map((e) => e).toList(),
      "bible": bible?.map((e) => e).toList(),
      "checked": checked,
      "isReviewed": isReviewed,
    };
  }
  UserModel copyWith({
    // String? address,
    // String? phone,
    // int? age,
    // bool? isTeacher,
    // String? birthday,
    // String? fatherName,
    // bool? isShams,
    // ParentsModel? parents,
    String? classId,
    String? name,
    String? profile,
    String? uid,
    List<MemberQuizzesModel?>? quizzes,
    bool? isAdmin,
    String? date,
    String? version,
    bool? isAnyUpdate,
    bool? checked,
    List<String>? football,
    List<String>? volleyball,
    List<String>? pingPong,
    List<String>? chess,
    List<String>? melodies,
    List<String>? choir,
    List<String>? ritual,
    List<String>? coptic,
    List<String>? doctrine,
    List<String>? bible,
    DateTime? birthdayDate,
    bool? isTeacher,
    bool? isReviewed,
    int? index,
  }){
    return UserModel(
      // address: address??this.address,
      // phone: phone??this.phone,
      // age: age??this.age,
      // birthday: birthday??this.birthday,
      // fatherName: fatherName??this.fatherName,
      // isShams: isShams??this.isShams,
      // parents: parents??this.parents,
      // birthdayDate: birthdayDate??this.birthdayDate,
      classId: classId??this.classId,
      name: name??this.name,
      profile: profile??this.profile,
      uid: uid??this.uid,
      isTeacher: isTeacher??this.isTeacher,
      quizzes: quizzes??this.quizzes,
      isAdmin: isAdmin??this.isAdmin,
      version: version??this.version,
      isAnyUpdate: isAnyUpdate??this.isAnyUpdate,
      checked: checked??this.checked,
      football: football??this.football,
      volleyball: volleyball??this.volleyball,
      pingPong: pingPong??this.pingPong,
      chess: chess??this.chess,
      melodies: melodies??this.melodies,
      choir: choir??this.choir,
      ritual: ritual??this.ritual,
      coptic: coptic??this.coptic,
      doctrine: doctrine??this.doctrine,
      bible: bible??this.bible,
      isReviewed: isReviewed??this.isReviewed,
    );
  }

}