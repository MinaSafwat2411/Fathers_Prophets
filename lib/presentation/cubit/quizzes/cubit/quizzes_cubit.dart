import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/services/cache/i_cache_helper.dart';
import 'package:fathers_prophets/domain/usecases/quizzes/quizzes_use_case.dart';
import 'package:fathers_prophets/presentation/cubit/quizzes/states/quizzes_states.dart';
import 'package:fathers_prophets/presentation/screens/add_quizzes_screen/day_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/bible/bible_model.dart';
import '../../../../data/models/quizzes/questions_model.dart';
import '../../../../data/models/quizzes/quiz_answers.dart';
import '../../../../data/models/quizzes/quiz_model.dart';
import '../../../../data/models/quizzes_score/quizzes_score_model.dart';
import '../../../../data/repositories/quizzes/quizzes_repository.dart';
import '../../../../data/repositories/quizzes_score/quizzes_score_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../domain/usecases/quizzes_score/quizzes_score_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';

class QuizzesCubit extends Cubit<QuizzesStates> {
  QuizzesCubit(this.cacheHelper) : super(InitialState());

  static QuizzesCubit get(context) => BlocProvider.of(context);

  final ICacheHelper cacheHelper;
  var userData = UserModel();
  var memberList = <UserModel>[];
  var adminList = <UserModel>[];
  var quizAnswers = QuizAnswers();
  late var quiz = QuizzesModel(
    friday: QuizModel(questions: [],shahid: ""),
    monday: QuizModel(questions: [],shahid: ""),
    saturday: QuizModel(questions: [],shahid: ""),
    sunday: QuizModel(questions: [],shahid: ""),
    thursday: QuizModel(questions: [],shahid: ""),
    tuesday: QuizModel(questions: [],shahid: ""),
    wednesday: QuizModel(questions: [],shahid: ""),
    number: cacheHelper.getQuizzes().length+1,
  );
  var selectedDate = "";
  TextEditingController controller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  var noOfQuestions = 5;
  var answerIndex = -1;
  var correctAnswer = [false, false, false, false, false];
  var question = <String>[];
  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final QuizzesUseCase quizzesUseCase = QuizzesUseCase(QuizzesRepository());
  final QuizzesScoreUseCase quizzesScoreUseCase = QuizzesScoreUseCase(QuizzesScoreRepository());

  var score = 0;
  var correctAnswersIndex = -1;
  var selectedTestament = "";
  var chapter = "";
  var from = "";
  var to = "";
  bool? isOldTestament;
  var selectedTestamentItem = BibleModel(name: "", chapters: 0);
  var questions = <QuestionsModel>[];
  List<Answer>? answers;
  var isAdd = false;

  void onOldOrNewTestament(bool value) {
    isOldTestament = value;
    emit(OnShahid());
  }

  void onChangeAnswer(int index) {}

  void onChapter(String chapter) {
    this.chapter = chapter;
    emit(OnShahid());
  }

  void onSelectTestament(BibleModel bibleModel) {
    selectedTestamentItem = bibleModel;
    selectedTestament = bibleModel.name;
    emit(OnShahid());
  }

  void createQuizAnswers(String docId, QuizzesModel quiz) {
    score = 0;
    userData = cacheHelper.getUserData();
    this.quiz = quiz;
    var cache = cacheHelper.getQuizAnswers(docId);
    if (cache != null) {
      quizAnswers = cache;
      emit(OnResume());
      return;
    } else {
      quizAnswers = QuizAnswers(
        docId: docId,
        wednesday: DayAnswers(
          answers: [
            Answer(answer: -1, questionIndex: 0),
            Answer(answer: -1, questionIndex: 1),
            Answer(answer: -1, questionIndex: 2),
            Answer(answer: -1, questionIndex: 3),
            Answer(answer: -1, questionIndex: 4),
          ],
        ),
        thursday: DayAnswers(
          answers: [
            Answer(answer: -1, questionIndex: 0),
            Answer(answer: -1, questionIndex: 1),
            Answer(answer: -1, questionIndex: 2),
            Answer(answer: -1, questionIndex: 3),
            Answer(answer: -1, questionIndex: 4),
          ],
        ),
        friday: DayAnswers(
          answers: [
            Answer(answer: -1, questionIndex: 0),
            Answer(answer: -1, questionIndex: 1),
            Answer(answer: -1, questionIndex: 2),
            Answer(answer: -1, questionIndex: 3),
            Answer(answer: -1, questionIndex: 4),
          ],
        ),
        monday: DayAnswers(
          answers: [
            Answer(answer: -1, questionIndex: 0),
            Answer(answer: -1, questionIndex: 1),
            Answer(answer: -1, questionIndex: 2),
            Answer(answer: -1, questionIndex: 3),
            Answer(answer: -1, questionIndex: 4),
          ],
        ),
        saturday: DayAnswers(
          answers: [
            Answer(answer: -1, questionIndex: 0),
            Answer(answer: -1, questionIndex: 1),
            Answer(answer: -1, questionIndex: 2),
            Answer(answer: -1, questionIndex: 3),
            Answer(answer: -1, questionIndex: 4),
          ],
        ),
        sunday: DayAnswers(
          answers: [
            Answer(answer: -1, questionIndex: 0),
            Answer(answer: -1, questionIndex: 1),
            Answer(answer: -1, questionIndex: 2),
            Answer(answer: -1, questionIndex: 3),
            Answer(answer: -1, questionIndex: 4),
          ],
        ),
        tuesday: DayAnswers(
          answers: [
            Answer(answer: -1, questionIndex: 0),
            Answer(answer: -1, questionIndex: 1),
            Answer(answer: -1, questionIndex: 2),
            Answer(answer: -1, questionIndex: 3),
            Answer(answer: -1, questionIndex: 4),
          ],
        ),
      );
    }
  }

  void updateQuizAnswers(int questionIndex, int answer, String day) {
    switch (day) {
      case "Friday":
        {
          quizAnswers.friday?.answers?[questionIndex].answer = answer;
          emit(OnAnswer());
          break;
        }
      case "Monday":
        {
          quizAnswers.monday?.answers?[questionIndex].answer = answer;
          emit(OnAnswer());
          break;
        }
      case "Saturday":
        {
          quizAnswers.saturday?.answers?[questionIndex].answer = answer;
          emit(OnAnswer());
          break;
        }
      case "Sunday":
        {
          quizAnswers.sunday?.answers?[questionIndex].answer = answer;
          emit(OnAnswer());
          break;
        }
      case "Tuesday":
        {
          quizAnswers.tuesday?.answers?[questionIndex].answer = answer;
          emit(OnAnswer());
          break;
        }
      case "Wednesday":
        {
          quizAnswers.wednesday?.answers?[questionIndex].answer = answer;
          emit(OnAnswer());
          break;
        }
      case "Thursday":
        {
          quizAnswers.thursday?.answers?[questionIndex].answer = answer;
          emit(OnAnswer());
          break;
        }
    }
  }

  void onSaveAnswers() async {
    await cacheHelper.saveQuizAnswers(quizAnswers);
    emit(OnGetBack());
  }

  void onSubmit() async {
    for (var i = 0; i <5 ; i++) {
      if (quizAnswers.friday?.answers?[i].answer ==
          quiz.friday?.questions?[i].correctAnswer) {
        score++;
      }
      if (quizAnswers.saturday?.answers?[i].answer ==
          quiz.saturday?.questions?[i].correctAnswer) {
        score++;
      }
      if (quizAnswers.sunday?.answers?[i].answer ==
          quiz.sunday?.questions?[i].correctAnswer) {
        score++;
      }
      if (quizAnswers.monday?.answers?[i].answer ==
          quiz.monday?.questions?[i].correctAnswer) {
        score++;
      }
      if (quizAnswers.tuesday?.answers?[i].answer ==
          quiz.tuesday?.questions?[i].correctAnswer) {
        score++;
      }
      if (quizAnswers.wednesday?.answers?[i].answer ==
          quiz.wednesday?.questions?[i].correctAnswer) {
        score++;
      }
      if (quizAnswers.thursday?.answers?[i].answer ==
          quiz.thursday?.questions?[i].correctAnswer) {
        score++;
      }
    }
    try {
      await quizzesScoreUseCase.updateQuizzesScore(userData.uid??"", QuizzesScoreModel(
        score: score,
        quizzes: [quiz.docId??""],
        name: userData.name
      ));
      emit(OnSubmit());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }

  void onAddQuiz()async{
    try{
      var docId = await quizzesUseCase.addNewQuiz(quiz);
      var quizzes = cacheHelper.getQuizzes();
      quiz= quiz.copyWith(docId: docId);
      quizzes.add(quiz);
      await cacheHelper.saveQuizzes(quizzes);
      emit(OnClose());
    }catch(e) {
      emit(OnError(e.toString()));
    }
  }

  void onSelectDate(DayEnum day) {
    if (selectedDate.isNotEmpty) {
      switch (day) {
        case DayEnum.FRIDAY:
          {
            selectedDate = "friday";
            emit(OnSelectDate());
            break;
          }
        case DayEnum.SATURDAY:
          {
            selectedDate = "saturday";
            emit(OnSelectDate());
            break;
          }
        case DayEnum.SUNDAY:
          {
            selectedDate = "sunday";
            emit(OnSelectDate());
            break;
          }
        case DayEnum.MONDAY:
          {
            selectedDate = "monday";
            emit(OnSelectDate());
            break;
          }
        case DayEnum.TUESDAY:
          {
            selectedDate = "tuesday";
            emit(OnSelectDate());
            break;
          }
        case DayEnum.WEDNESDAY:
          {
            selectedDate = "wednesday";
            emit(OnSelectDate());
            break;
          }
        case DayEnum.THURSDAY:
          {
            selectedDate = "thursday";
            emit(OnSelectDate());
            break;
          }
      }
      getQuestions();
    } else {
      selectedDate = "friday";
      onRestQuestionAdd();
      emit(OnSelectDate());
    }
  }

  void onAddQuestion() {
    if (question.isNotEmpty) {
      switch (selectedDate) {
        case "friday":
          {
            if (quiz.friday?.questions?.length != 5) {
              quiz.friday?.questions?.add(
                QuestionsModel(
                  question: question[0],
                  answers: question.sublist(1),
                  correctAnswer: correctAnswersIndex,
                ),
              );
            } else {
              emit(OnLimitQuestions());
            }
            quiz.friday?.shahid = "$selectedTestament $chapter ($from - $to)";
            break;
          }
        case "saturday":
          {
            if (quiz.saturday?.questions?.length != 5) {
              quiz.saturday?.questions?.add(
                QuestionsModel(
                  question: question[0],
                  answers: question.sublist(1),
                  correctAnswer: correctAnswersIndex,
                ),
              );
            } else {
              emit(OnLimitQuestions());
            }
            quiz.saturday?.shahid = "$selectedTestament $chapter ($from - $to)";
            break;
          }
        case "sunday":
          {
            if (quiz.sunday?.questions?.length != 5) {
              quiz.sunday?.questions?.add(
                QuestionsModel(
                  question: question[0],
                  answers: question.sublist(1),
                  correctAnswer: correctAnswersIndex,
                ),
              );
            } else {
              emit(OnLimitQuestions());
            }
            quiz.sunday?.shahid = "$selectedTestament $chapter ($from - $to)";
            break;
          }
        case "monday":
          {
            if (quiz.monday?.questions?.length != 5) {
              quiz.monday?.questions?.add(
                QuestionsModel(
                  question: question[0],
                  answers: question.sublist(1),
                  correctAnswer: correctAnswersIndex,
                ),
              );
            } else {
              emit(OnLimitQuestions());
            }
            quiz.monday?.shahid = "$selectedTestament $chapter ($from - $to)";
            break;
          }
        case "tuesday":
          {
            if (quiz.tuesday?.questions?.length != 5) {
              quiz.tuesday?.questions?.add(
                QuestionsModel(
                  question: question[0],
                  answers: question.sublist(1),
                  correctAnswer: correctAnswersIndex,
                ),
              );
            } else {
              emit(OnLimitQuestions());
            }
            quiz.tuesday?.shahid = "$selectedTestament $chapter ($from - $to)";
            break;
          }
        case "wednesday":
          {
            if (quiz.wednesday?.questions?.length != 5) {
              quiz.wednesday?.questions?.add(
                QuestionsModel(
                  question: question[0],
                  answers: question.sublist(1),
                  correctAnswer: correctAnswersIndex,
                ),
              );
            } else {
              emit(OnLimitQuestions());
            }
            quiz.wednesday?.shahid = "$selectedTestament $chapter ($from - $to)";
            break;
          }
        case "thursday":
          {
            if (quiz.thursday?.questions?.length != 5) {
              quiz.thursday?.questions?.add(
                QuestionsModel(
                  question: question[0],
                  answers: question.sublist(1),
                  correctAnswer: correctAnswersIndex,
                ),
              );
            } else {
              emit(OnLimitQuestions());
            }
            quiz.thursday?.shahid = "$selectedTestament $chapter ($from - $to)";
            break;
          }
      }
    }
    getQuestions();
    onRestQuestionAdd();
    emit(OnResetAll());
  }

  int noOfQuestionsChanged(String day) {
    switch (day) {
      case "friday":
        {
          return quiz.friday?.questions?.length ?? 0;
        }
      case "saturday":
        {
          return quiz.saturday?.questions?.length ?? 0;
        }
      case "sunday":
        {
          return quiz.sunday?.questions?.length ?? 0;
        }
      case "monday":
        {
          return quiz.monday?.questions?.length ?? 0;
        }

      case "tuesday":
        {
          return quiz.tuesday?.questions?.length ?? 0;
        }

      case "wednesday":
        {
          return quiz.wednesday?.questions?.length ?? 0;
        }
      case "thursday":
        {
          return quiz.thursday?.questions?.length ?? 0;
        }
      default:
        {
          return 0;
        }
    }
  }

  void onQuestionControllerChanged() {
    emit(OnQuestionControllerChange());
  }

  void onRestQuestionAdd() {
    controller.clear();
    question.clear();
    Future.delayed(Duration(seconds: 1), () {
      emit(OnAddQuestion());

    });
  }

  void onRestAll(){
    quizAnswers = QuizAnswers();
    quiz = QuizzesModel(
      friday: QuizModel(questions: [],shahid: ""),
      monday: QuizModel(questions: [],shahid: ""),
      saturday: QuizModel(questions: [],shahid: ""),
      sunday: QuizModel(questions: [],shahid: ""),
      thursday: QuizModel(questions: [],shahid: ""),
      tuesday: QuizModel(questions: [],shahid: ""),
      wednesday: QuizModel(questions: [],shahid: ""),
      number: cacheHelper.getQuizzes().length+1,
    );
    selectedDate = "";
    noOfQuestions = 5;
    answerIndex = -1;
    correctAnswer = [false, false, false, false, false];
    question = <String>[];
    score = 0;
    correctAnswersIndex = -1;
    selectedTestament = "";
    chapter = "";
    from = "";
    to = "";
    isOldTestament=null;
    selectedTestamentItem = BibleModel(name: "", chapters: 0);
    questions = <QuestionsModel>[];
    answers=<Answer>[];
    isAdd = false;
    controller.clear();
    question.clear();
    fromController.clear();
    toController.clear();
  }

  final List<BibleModel> oldTestamentBooks = [
    BibleModel(name: "التكوين", chapters: 50),
    BibleModel(name: "الخروج", chapters: 40),
    BibleModel(name: "اللاويين", chapters: 27),
    BibleModel(name: "العدد", chapters: 36),
    BibleModel(name: "التثنية", chapters: 34),
    BibleModel(name: "يشوع", chapters: 24),
    BibleModel(name: "القضاة", chapters: 21),
    BibleModel(name: "راعوث", chapters: 4),
    BibleModel(name: "صموئيل الأول", chapters: 31),
    BibleModel(name: "صموئيل الثاني", chapters: 24),
    BibleModel(name: "الملوك الأول", chapters: 22),
    BibleModel(name: "الملوك الثاني", chapters: 25),
    BibleModel(name: "أخبار الأيام الأول", chapters: 29),
    BibleModel(name: "أخبار الأيام الثاني", chapters: 36),
    BibleModel(name: "عزرا", chapters: 10),
    BibleModel(name: "نحميا", chapters: 13),
    BibleModel(name: "أستير", chapters: 10),
    BibleModel(name: "أيوب", chapters: 42),
    BibleModel(name: "المزامير", chapters: 150),
    BibleModel(name: "الأمثال", chapters: 31),
    BibleModel(name: "الجامعة", chapters: 12),
    BibleModel(name: "نشيد الأنشاد", chapters: 8),
    BibleModel(name: "إشعياء", chapters: 66),
    BibleModel(name: "إرميا", chapters: 52),
    BibleModel(name: "مراثي إرميا", chapters: 5),
    BibleModel(name: "حزقيال", chapters: 48),
    BibleModel(name: "دانيال", chapters: 12),
    BibleModel(name: "هوشع", chapters: 14),
    BibleModel(name: "يوئيل", chapters: 3),
    BibleModel(name: "عاموس", chapters: 9),
    BibleModel(name: "عوبديا", chapters: 1),
    BibleModel(name: "يونان", chapters: 4),
    BibleModel(name: "ميخا", chapters: 7),
    BibleModel(name: "ناحوم", chapters: 3),
    BibleModel(name: "حبقوق", chapters: 3),
    BibleModel(name: "صفنيا", chapters: 3),
    BibleModel(name: "حجّي", chapters: 2),
    BibleModel(name: "زكريا", chapters: 14),
    BibleModel(name: "ملاخي", chapters: 4),
  ];

  final List<BibleModel> newTestamentBooks = [
    BibleModel(name: "متى", chapters: 28),
    BibleModel(name: "مرقس", chapters: 16),
    BibleModel(name: "لوقا", chapters: 24),
    BibleModel(name: "يوحنا", chapters: 21),
    BibleModel(name: "أعمال الرسل", chapters: 28),
    BibleModel(name: "رومية", chapters: 16),
    BibleModel(name: "كورنثوس الأولى", chapters: 16),
    BibleModel(name: "كورنثوس الثانية", chapters: 13),
    BibleModel(name: "غلاطية", chapters: 6),
    BibleModel(name: "أفسس", chapters: 6),
    BibleModel(name: "فيلبي", chapters: 4),
    BibleModel(name: "كولوسي", chapters: 4),
    BibleModel(name: "تسالونيكي الأولى", chapters: 5),
    BibleModel(name: "تسالونيكي الثانية", chapters: 3),
    BibleModel(name: "تيموثاوس الأولى", chapters: 6),
    BibleModel(name: "تيموثاوس الثانية", chapters: 4),
    BibleModel(name: "تيطس", chapters: 3),
    BibleModel(name: "فليمون", chapters: 1),
    BibleModel(name: "العبرانيين", chapters: 13),
    BibleModel(name: "يعقوب", chapters: 5),
    BibleModel(name: "بطرس الأولى", chapters: 5),
    BibleModel(name: "بطرس الثانية", chapters: 3),
    BibleModel(name: "يوحنا الأولى", chapters: 5),
    BibleModel(name: "يوحنا الثانية", chapters: 1),
    BibleModel(name: "يوحنا الثالثة", chapters: 1),
    BibleModel(name: "يهوذا", chapters: 1),
    BibleModel(name: "رؤيا يوحنا", chapters: 22),
  ];

  void onAddAnswer() {
    if (controller.text.isNotEmpty && question.length <= 4) {
      question.add(controller.text);
      controller.clear();
      emit(OnQuestionIndexIncrease());
    }
  }

  void onDeleteAnswer(int index) {
    question.removeAt(index);
    emit(OnQuestionIndexIncrease());
  }

  void onCorrectAnswer(int index) {
    correctAnswer = [false, false, false, false, false];
    correctAnswer[index] = !correctAnswer[index];
    correctAnswersIndex = index - 1;
    emit(OnAnswer());
  }


  void onAddedVerse() {
    from = fromController.text;
    to = toController.text;
    emit(OnShahid());
  }

  void onReview() {
    if (from.isNotEmpty&&to.isNotEmpty&&quiz.friday?.questions?.length==5&&quiz.saturday?.questions?.length==5&&quiz.sunday?.questions?.length==5&&quiz.monday?.questions?.length==5&&quiz.tuesday?.questions?.length==5&&quiz.wednesday?.questions?.length==5&&quiz.thursday?.questions?.length==5) {
      emit(OnReview());
    }else{
      emit(OnError("add_more_questions"));
    }
  }

  void getQuestions() {
    switch (selectedDate) {
      case "friday":
        {
          questions = quiz.friday?.questions ?? [];
        }
      case "saturday":
        {
          questions = quiz.saturday?.questions ?? [];
        }
      case "sunday":
        {
          questions = quiz.sunday?.questions ?? [];
        }
      case "monday":
        {
          questions = quiz.monday?.questions ?? [];
        }

      case "tuesday":
        {
          questions = quiz.tuesday?.questions ?? [];
        }

      case "wednesday":
        {
          questions = quiz.wednesday?.questions ?? [];
        }

      case "thursday":
        {
          questions = quiz.thursday?.questions ?? [];
        }
    }
  }

  void onDeleteQuestion(int index) {
    switch (selectedDate) {
      case "friday":
        {
          quiz.friday?.questions?.removeAt(index);
        }
      case "saturday":
        {
          quiz.saturday?.questions?.removeAt(index);
        }
      case "sunday":
        {
          quiz.sunday?.questions?.removeAt(index);
        }

      case "monday":
        {
          quiz.monday?.questions?.removeAt(index);
        }
      case "tuesday":
        {
          quiz.tuesday?.questions?.removeAt(index);
        }
      case "wednesday":
        {
          quiz.wednesday?.questions?.removeAt(index);
        }
      case "thursday":
        {
          quiz.thursday?.questions?.removeAt(index);
        }
    }
    emit(OnQuestionIndexDecrease());
  }
}
