class ClassMemberModel {
  final String? name;
  final String? uid;

  ClassMemberModel({
    this.name,
    this.uid,
});

  factory ClassMemberModel.fromJson(Map<String, dynamic> json) {
    return ClassMemberModel(
      name: json['name']??"",
      uid: json['uid']??"",
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'uid': uid,
  };
}