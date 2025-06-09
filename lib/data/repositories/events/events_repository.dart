import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';

class EventsRepository {
  Future<List<EventsModel>?> getFootballEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Football").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
        .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
        .toList();
    }
  }
  Future<List<EventsModel>?> getVolleyballEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Volleyball").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }
  }
  Future<List<EventsModel>?> getBibleEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Bible").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }
  }
  Future<List<EventsModel>?> getRitualEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Ritual").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }
  }
  Future<List<EventsModel>?> getDoctrineEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Doctrine").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }

  }
  Future<List<EventsModel>?> getCopticEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Coptic").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }
  }
  Future<List<EventsModel>?> getChoirEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Choir").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }
  }
  Future<List<EventsModel>?> getChessEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Chess").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }
  }
  Future<List<EventsModel>?> getPingPongEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("PingPong").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
    return snapshot.docs
        .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
        .toList();
    }
  }
  Future<List<EventsModel>?> getMelodiesEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection("Melodies").get();
    if(snapshot.docs.isEmpty){
      return [];
    }else {
      return snapshot.docs
          .map((doc) => EventsModel.fromJson(doc.data(), doc.id))
          .toList();
    }
  }
  Future<String?> addNewFootballEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Football").add(eventsModel.toJson());
    return snapshot.id;
  }
  Future<String?> addNewVolleyballEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Volleyball").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewBibleEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Bible").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewRitualEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Ritual").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewDoctrineEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Doctrine").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewCopticEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Coptic").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewChoirEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Choir").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewChessEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Chess").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewPingPongEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("PingPong").add(eventsModel.toJson());
    return snapshot.id;
  }

  Future<String?> addNewMelodiesEvent(EventsModel eventsModel)async{
    final snapshot = await FirebaseFirestore.instance.collection("Melodies").add(eventsModel.toJson());
    return snapshot.id;
  }
}