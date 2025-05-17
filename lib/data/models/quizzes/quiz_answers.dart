class QuizAnswers {
  DayAnswers? friday;
  DayAnswers? saturday;
  DayAnswers? sunday;
  DayAnswers? monday;
  DayAnswers? tuesday;
  DayAnswers? wednesday;
  DayAnswers? thursday;
  String? docId;

  QuizAnswers({
    this.friday,
    this.saturday,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.docId
});

  factory QuizAnswers.fromJson(Map<String, dynamic> json) {
    return QuizAnswers(
      friday: json['friday'] != null ? DayAnswers.fromJson(json['friday']) : null,
      saturday: json['saturday'] != null ? DayAnswers.fromJson(json['saturday']) : null,
      sunday: json['sunday'] != null ? DayAnswers.fromJson(json['sunday']) : null,
      monday: json['monday'] != null ? DayAnswers.fromJson(json['monday']) : null,
      tuesday: json['tuesday'] != null ? DayAnswers.fromJson(json['tuesday']) : null,
      wednesday: json['wednesday'] != null ? DayAnswers.fromJson(json['wednesday']) : null,
      thursday: json['thursday'] != null ? DayAnswers.fromJson(json['thursday']) : null,
      docId: json['docId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'friday': friday?.toJson(),
      'saturday': saturday?.toJson(),
      'sunday': sunday?.toJson(),
      'monday': monday?.toJson(),
      'tuesday': tuesday?.toJson(),
      'wednesday': wednesday?.toJson(),
      'thursday': thursday?.toJson(),
      'docId': docId
    };
  }
}

class Answer{
  int? questionIndex;
  int? answer;

  Answer({
    this.questionIndex,
    this.answer
});
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
        questionIndex: json['questionIndex'],
        answer: json['answer']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionIndex': questionIndex,
      'answer': answer
    };
  }
}

class DayAnswers{
  List<Answer>? answers;
  int? dayNo;

  DayAnswers({
    this.answers,
    this.dayNo
});
  factory DayAnswers.fromJson(Map<String, dynamic> json) {
    return DayAnswers(
      answers: json['answers'] != null ? (json['answers'] as List).map((e) => Answer.fromJson(e)).toList() : null,
      dayNo: json['dayNo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answers': answers?.map((e) => e.toJson()).toList(),
      'dayNo': dayNo
    };
  }
}