import 'package:fathers_prophets/data/repositories/events/events_repository.dart';
import 'package:fathers_prophets/domain/usecases/events/i_events_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/events/events_model.dart';
import '../../../data/repositories/events/i_events_repository.dart';

@LazySingleton(as: IEventsUseCase)
class EventsUseCase implements IEventsUseCase{
  final IEventsRepository eventsRepository;
  EventsUseCase(this.eventsRepository);

  @override
  Future<String> addNewEventByName(EventsModel eventsModel,String event) async {
    return await eventsRepository.addNewEventByName(eventsModel, event)??"";
  }

  @override
  Future<void> addEventAttendance(List<String> attendance, String eventId, String event){
    return eventsRepository.addEventAttendance(attendance, eventId, event);
  }

  @override
  Future<List<EventsModel>> getEventsByName(String event) async {
    return await eventsRepository.getEventsByName(event)??[];
  }

}