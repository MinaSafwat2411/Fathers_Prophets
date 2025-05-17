
import 'class_member_model.dart';

class ClassModel {
  final List<ClassMemberModel?>? members;
  final String? name;
  final String? docId;

  ClassModel({this.members, this.name, this.docId});

  factory ClassModel.fromJson(Map<String, dynamic> json,String docId){
    return ClassModel(
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => ClassMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name']??"",
      docId: docId,
    );
  }

  Map<String, dynamic> toJson() => {
    'members': members?.map((e) => e?.toJson()).toList(),
    'name': name,
    'docId': docId,
  };
}
