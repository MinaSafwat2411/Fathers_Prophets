import 'package:fathers_prophets/data/models/classes/class_user_model.dart';

class ClassModel {
  final String? name;
  final String? docId;
  final List<ClassUserModel>? members;
  final List<ClassUserModel>? servants;

  ClassModel({this.name, this.docId,this.members,this.servants});

  factory ClassModel.fromJson(Map<String, dynamic> json,String docId){
    return ClassModel(
      name: json['name']??"",
      docId: docId,
      members: json['members']!=null? (json['members'] as List<dynamic>?)?.map((e) => ClassUserModel.fromJson(e)).toList() : [],
      servants: json['servants']!=null? (json['servants'] as List<dynamic>?)?.map((e) => ClassUserModel.fromJson(e)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'docId': docId,
    'members': members?.map((e) => e.toJson()).toList() ?? [],
    'servants': servants?.map((e) => e.toJson()).toList() ?? [],
  };

  ClassModel copyWith({
    String? name,
    String? docId,
    List<ClassUserModel>?members,
    List<ClassUserModel>?servants,
}){
    return ClassModel(
      members: members??this.members,
      servants: members??this.servants,
      name: name??this.name,
      docId: docId?? this.docId
    );
  }
}
