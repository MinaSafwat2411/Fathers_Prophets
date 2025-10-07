import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/data/models/quizzes_score/quizzes_score_model.dart';

import '../../../core/constants/firebase_endpoints.dart';

abstract class IQuizzesScoreRepository {

  Future<List<QuizzesScoreModel>> getQuizzesScore();

  Future<QuizzesScoreModel?> getQuizzesScoreById(String id);

  Future<void> addNewQuizzesScore(String uid,QuizzesScoreModel quizzesScoreModel);

  Future<void> updateQuizzesScore(String uid,QuizzesScoreModel quizzesScoreModel);
}