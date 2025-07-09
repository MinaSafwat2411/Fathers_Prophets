import 'package:fathers_prophets/data/repositories/events/events_repository.dart';

import '../../../data/models/events/events_model.dart';

class EventsUseCase {
  final EventsRepository eventsRepository;
  EventsUseCase(this.eventsRepository);

  Future<String> addNewEventByName(EventsModel eventsModel,String event) async {
    return await eventsRepository.addNewEventByName(eventsModel, event)??"";
  }

  Future<void> addEventAttendance(List<String> attendance, String eventId, String event){
    return eventsRepository.addEventAttendance(attendance, eventId, event);
  }

  Future<List<EventsModel>> getEventsByName(String event) async {
    return await eventsRepository.getEventsByName(event)??[];
  }

}