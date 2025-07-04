class QuizzesScoreModel {
  final int? score;
  final List<String>? quizzes;

  QuizzesScoreModel({
     this.score,
     this.quizzes,
  });

  factory QuizzesScoreModel.fromJson(Map<String, dynamic> json) {
    return QuizzesScoreModel(
      score: json['score'] ?? 0,
      quizzes: (json['quizzes'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'score': score,
    'quizzes': quizzes,
  };

  QuizzesScoreModel copyWith({
    int? score,
    List<String>? quizzes,
}){
    return QuizzesScoreModel(
      score: score ?? this.score,
      quizzes: quizzes ?? this.quizzes,
    );
  }

}