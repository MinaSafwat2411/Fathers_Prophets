class ClassModel {
  final String? name;
  final String? docId;

  ClassModel({this.name, this.docId});

  factory ClassModel.fromJson(Map<String, dynamic> json,String docId){
    return ClassModel(
      name: json['name']??"",
      docId: docId,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'docId': docId,
  };
}
