import '../../models/classes/class_model.dart';
import '../../models/events/events_model.dart';
import '../../models/quizzes/quiz_answers.dart';
import '../../models/quizzes/quizzes_model.dart';
import '../../models/users/users_model.dart';

abstract class ICacheHelper {
  dynamic getData({required String key});

  Future<bool> saveData({required String key, required dynamic value});

  Future<bool> removeData({required String key});

  Future<bool> saveIntList({required String key, required List<int> value});
  List<int>? getIntList({required String key});

  // Classes
  Future<bool> saveClasses(List<ClassModel> classes);
  List<ClassModel> getClasses();
  Future<bool> removeClasses();

  // Quizzes
  Future<bool> saveQuizzes(List<QuizzesModel?> quizzes);
  List<QuizzesModel> getQuizzes();
  Future<bool> removeQuizzes();

  // User
  Future<bool> saveUserData(UserModel user);
  UserModel getUserData();
  Future<bool> removeUserData();

  // Quiz Answers
  Future<bool> saveQuizAnswers(QuizAnswers quizAnswers);
  QuizAnswers getQuizAnswers(String docId);

  // Events
  Future<bool> saveEvents(List<EventsModel?> events, String key);
  List<EventsModel> getEvents(String key);
  Future<bool> removeEvents(String key);
}
