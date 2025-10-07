import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../models/quizzes/quizzes_model.dart';
import 'i_quizzes_repository.dart';

@LazySingleton(as: IQuizzesRepository)
class QuizzesRepository implements IQuizzesRepository{
  @override
  Future<List<QuizzesModel?>?> getAllQuizzes() async {
    final snapshot = await FirebaseFirestore.instance.collection("Quizzes").get();
    return snapshot.docs
        .map((doc) => QuizzesModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  @override
  Future<String?> addNewQuiz(QuizzesModel quizzesModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Quizzes").add(quizzesModel.toJson());
    return snapshot.id;
  }
  @override
  Future<void> updateQuiz(QuizzesModel quizzesModel)async{
    await FirebaseFirestore.instance.collection("Quizzes").doc(quizzesModel.docId).update(quizzesModel.toJson());
  }
  @override
  Future<void> deleteQuiz(String id)async{
    await FirebaseFirestore.instance.collection("Quizzes").doc(id).delete();
  }
  @override
  Future<QuizzesModel?> getQuizById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection("Quizzes").doc(id).get();
    return QuizzesModel.fromJson(snapshot.data()!,snapshot.id);
  }
}