class SplashModel {
  final bool? requireToUpdate;

  SplashModel({this.requireToUpdate});

  factory SplashModel.fromJson(Map<String, dynamic> json) {
    return SplashModel(requireToUpdate: json['requireToUpdate'] ?? true);
  }

  Map<String, dynamic> toJson() => {'requireToUpdate': requireToUpdate};

  SplashModel copyWith({bool? requireToUpdate}) {
    return SplashModel(
      requireToUpdate: requireToUpdate ?? this.requireToUpdate,
    );
  }
}
