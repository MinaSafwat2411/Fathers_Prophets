import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/data/models/quizzes_score/quizzes_score_model.dart';

import '../../../core/constants/firebase_endpoints.dart';

class QuizzesScoreRepository {

  Future<List<QuizzesScoreModel>> getQuizzesScore() async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.quizzesScore).where('score', isGreaterThan: 0).get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => QuizzesScoreModel.fromJson(doc.data())).toList();
    }
  }

  Future<QuizzesScoreModel?> getQuizzesScoreById(String id) async {
    final snapshot = await FirebaseFirestore.instance.collection(FirebaseEndpoints.quizzesScore).doc(id).get();
    if(snapshot.exists){
      return QuizzesScoreModel.fromJson(snapshot.data()!);
    }else {
      return null;
    }
  }

  Future<void> addNewQuizzesScore(String uid,QuizzesScoreModel quizzesScoreModel)async {
    if (uid.isNotEmpty) {
      await FirebaseFirestore.instance.collection(FirebaseEndpoints.quizzesScore).doc(uid).set(quizzesScoreModel.toJson());
    }
  }

  Future<void> updateQuizzesScore(String uid,QuizzesScoreModel quizzesScoreModel)async {
    if (uid.isNotEmpty) {
      await FirebaseFirestore.instance.collection(FirebaseEndpoints.quizzesScore).doc(uid).update(
          {
            'quizzes': FieldValue.arrayUnion(quizzesScoreModel.quizzes??[]),
            'score': FieldValue.increment(quizzesScoreModel.score??0),
            'name': quizzesScoreModel.name,
          }
      );
    }
  }
}