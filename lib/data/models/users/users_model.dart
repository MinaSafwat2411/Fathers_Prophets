
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
  final bool? isAdmin;
  final String? role;
  final bool? isAnyUpdate;
  final bool? isReviewed;
  bool? canPreview = false;
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
    this.isAdmin,
    this.isAnyUpdate,
    this.checked,
    this.isReviewed,
    this.canPreview,
    this.role
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
      isTeacher: json['isTeacher']??false,
      isAdmin: json['isAdmin']??false,
      isAnyUpdate: json["isAnyUpdate"]??false,
      checked: false,
      isReviewed: json['isReviewed']??false,
      canPreview: json['isAdmin']??false,
      role: json['role']??'',
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
      'isTeacher':isTeacher,
      'isAdmin':isAdmin,
      'uid':uid,
      "isAnyUpdate": isAnyUpdate,
      "isReviewed": isReviewed,
      "role": role,
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
    bool? isAdmin,
    String? date,
    bool? isAnyUpdate,
    bool? checked,
    DateTime? birthdayDate,
    bool? isTeacher,
    bool? isReviewed,
    int? index,
    bool? canPreview,
    String? role,
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
      isAdmin: isAdmin??this.isAdmin,
      isAnyUpdate: isAnyUpdate??this.isAnyUpdate,
      checked: checked??this.checked,
      isReviewed: isReviewed??this.isReviewed,
      canPreview: canPreview??this.canPreview,
      role: role??this.role,
    );
  }

}