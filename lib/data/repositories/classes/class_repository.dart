import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';

class ClassRepository {
  Future<List<ClassModel?>?> getAllClasses() async {
    final snapshot =
    await FirebaseFirestore.instance.collection("Classes").get();
    return snapshot.docs
        .map((doc) => ClassModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  Future<String?> addNewClass(ClassModel classModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Classes").add(classModel.toJson());
    return snapshot.id;
  }
  Future<void> updateClass(ClassModel classModel)async{
    await FirebaseFirestore.instance.collection("Classes").doc(classModel.docId).update(classModel.toJson());
  }
  Future<void> deleteClass(String id)async{
    await FirebaseFirestore.instance.collection("Classes").doc(id).delete();
  }

  Future<ClassModel?> getClassById(String id)async{
    final snapshot = await FirebaseFirestore.instance.collection("Classes").doc(id).get();
    return ClassModel.fromJson(snapshot.data()!,snapshot.id);
  }
}