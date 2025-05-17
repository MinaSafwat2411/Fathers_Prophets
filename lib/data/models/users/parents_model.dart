class ParentsModel {
  final String? fatherPhone;
  final String? motherPhone;

  ParentsModel({
    this.fatherPhone,
    this.motherPhone,
});

  factory ParentsModel.fromJson(Map<String, dynamic> json) {
    return ParentsModel(
      fatherPhone: json['fatherPhone']??"",
      motherPhone: json['motherPhone']??"",
    );
  }

  Map<String, dynamic> toJson() => {
    'fatherPhone': fatherPhone,
    'motherPhone': motherPhone,
  };
}