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

}