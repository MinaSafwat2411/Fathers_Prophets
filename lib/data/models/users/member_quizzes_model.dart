 class MemberQuizzesModel {
  final int? degree;
  final String? docId;

  MemberQuizzesModel({
    this.degree,
    this.docId,
 });

  factory MemberQuizzesModel.fromJson(Map<String, dynamic> json) {
    return MemberQuizzesModel(
      degree: json['degree'] ?? 0,
      docId: json['docId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    'degree': degree,
    'docId': docId,
  };
 }