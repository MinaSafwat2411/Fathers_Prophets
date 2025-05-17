import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/quizzes/quizzes_model.dart';

class QuizzesRepository {
  Future<List<QuizzesModel?>?> getAllQuizzes() async {
    final snapshot = await FirebaseFirestore.instance.collection("Quizzes").get();
    return snapshot.docs
        .map((doc) => QuizzesModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  Future<String?> addNewQuiz(QuizzesModel quizzesModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Quizzes").add(quizzesModel.toJson());
    return snapshot.id;
  }
  Future<void> updateQuiz(QuizzesModel quizzesModel)async{
    await FirebaseFirestore.instance.collection("Quizzes").doc(quizzesModel.docId).update(quizzesModel.toJson());
  }
  Future<void> deleteQuiz(String id)async{
    await FirebaseFirestore.instance.collection("Quizzes").doc(id).delete();
  }
  Future<QuizzesModel?> getQuizById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection("Quizzes").doc(id).get();
    return QuizzesModel.fromJson(snapshot.data()!,snapshot.id);
  }
}