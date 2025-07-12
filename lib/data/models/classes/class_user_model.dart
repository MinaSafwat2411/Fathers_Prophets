class ClassUserModel {
  final String? uid;
  final String? name;
  final bool? isTeacher;

  ClassUserModel({
    this.uid,
    this.name,
    this.isTeacher
});

  factory ClassUserModel.fromJson(Map<String, dynamic> json){
    return ClassUserModel(
      uid: json['uid']??"",
      name: json['name']??"",
      isTeacher: json['isTeacher']??false,
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'isTeacher': isTeacher
  };
}