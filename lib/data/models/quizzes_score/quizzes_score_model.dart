class QuizzesScoreModel {
  final int? score;
  final String? name;
  final List<String>? quizzes;

  QuizzesScoreModel({
     this.score,
     this.quizzes,
     this.name,
  });

  factory QuizzesScoreModel.fromJson(Map<String, dynamic> json) {
    return QuizzesScoreModel(
      score: json['score'] ?? 0,
      quizzes: (json['quizzes'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'score': score,
    'quizzes': quizzes,
    'name': name,
  };

  QuizzesScoreModel copyWith({
    int? score,
    List<String>? quizzes,
    String? name,
}){
    return QuizzesScoreModel(
      score: score ?? this.score,
      quizzes: quizzes ?? this.quizzes,
      name: name ?? this.name,
    );
  }

}