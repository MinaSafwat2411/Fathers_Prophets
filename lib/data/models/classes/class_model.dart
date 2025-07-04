class ClassModel {
  final String name;
  final String docId;

  ClassModel({required this.name, required this.docId});

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
