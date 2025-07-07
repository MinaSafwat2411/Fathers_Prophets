import 'package:fathers_prophets/data/repositories/events/events_repository.dart';

import '../../../data/models/events/events_model.dart';

class EventsUseCase {
  final EventsRepository eventsRepository;
  EventsUseCase(this.eventsRepository);

  Future<List<EventsModel>> getFootballEvents() async {
    return await eventsRepository.getFootballEvents()??[];
  }
  Future<List<EventsModel>> getVolleyballEvents() async {
    return await eventsRepository.getVolleyballEvents()??[];
  }

  Future<List<EventsModel>> getBibleEvents() async {
    return await eventsRepository.getBibleEvents()??[];
  }
  Future<List<EventsModel>> getRitualEvents() async {
    return await eventsRepository.getRitualEvents()??[];
  }

  Future<List<EventsModel>> getDoctrineEvents() async {
    return await eventsRepository.getDoctrineEvents()??[];
  }
  Future<List<EventsModel>> getCopticEvents() async {
    return await eventsRepository.getCopticEvents()??[];
  }

  Future<List<EventsModel>> getChoirEvents() async {
    return await eventsRepository.getChoirEvents()??[];
  }

  Future<List<EventsModel>> getChessEvents() async {
    return await eventsRepository.getChessEvents()??[];
  }
  Future<List<EventsModel>> getPingPongEvents() async {
    return await eventsRepository.getPingPongEvents()??[];
  }

  Future<List<EventsModel>> getMelodiesEvents() async {
    return await eventsRepository.getMelodiesEvents()??[];
  }
  Future<String> addNewFootballEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewFootballEvent(eventsModel)??"";
  }

  Future<String> addNewVolleyballEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewVolleyballEvent(eventsModel)??"";
  }

  Future<String> addNewBibleEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewBibleEvent(eventsModel)??"";
  }

  Future<String> addNewRitualEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewRitualEvent(eventsModel)??"";
  }

  Future<String> addNewDoctrineEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewDoctrineEvent(eventsModel)??"";
  }

  Future<String> addNewCopticEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewCopticEvent(eventsModel)??"";
  }

  Future<String> addNewChoirEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewChoirEvent(eventsModel)??"";
  }

  Future<String> addNewChessEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewChessEvent(eventsModel)??"";
  }


  Future<String> addNewPingPongEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewPingPongEvent(eventsModel)??"";
  }


  Future<String> addNewMelodiesEvent(EventsModel eventsModel)async{
    return await eventsRepository.addNewMelodiesEvent(eventsModel)??"";
  }

  Future<List<EventsModel>> getPrayEvents() async {
    return await eventsRepository.getPrayEvents()??[];
  }

  Future<List<EventsModel>> getPraiseEvents() async {
    return await eventsRepository.getPraiseEvents()??[];
  }

  Future<String> addNewPrayEvent(EventsModel eventsModel) async {
    return await eventsRepository.addNewPrayEvent(eventsModel)??'';
  }

  Future<String> addNewPraiseEvent(EventsModel eventsModel) async {
    return await eventsRepository.addNewPraiseEvent(eventsModel)??'';
  }

  Future<void> addFootballAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addFootballAttendance(attendance, eventId);
  }

  Future<void> addVolleyballAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addVolleyballAttendance(attendance, eventId);
  }


  Future<void> addBibleAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addBibleAttendance(attendance, eventId);
  }

  Future<void> addRitualAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addRitualAttendance(attendance, eventId);
  }

  Future<void> addDoctrineAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addDoctrineAttendance(attendance, eventId);
  }

  Future<void> addCopticAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addCopticAttendance(attendance, eventId);
  }

  Future<void> addChoirAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addChoirAttendance(attendance, eventId);
  }

  Future<void> addChessAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addChessAttendance(attendance, eventId);
  }

  Future<void> addPingPongAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addPingPongAttendance(attendance, eventId);
  }

  Future<void> addMelodiesAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addMelodiesAttendance(attendance, eventId);
  }

  Future<void> addPrayAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addPrayAttendance(attendance, eventId);
  }

  Future<void> addPraiseAttendance(List<String> attendance, String eventId) async {
    await eventsRepository.addPraiseAttendance(attendance, eventId);
  }

}