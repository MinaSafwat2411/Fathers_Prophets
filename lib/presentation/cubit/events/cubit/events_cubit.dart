import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:fathers_prophets/domain/usecases/users/users_use_case.dart';
import 'package:fathers_prophets/presentation/screens/add_event_screen/event_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/events/event_attendance_model.dart';
import '../../../../data/repositories/events/events_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/google_drive_service.dart';
import '../../../../domain/usecases/events/events_use_case.dart';
import '../states/events_states.dart';

class EventsCubit extends Cubit<EventsStates> {
  EventsCubit() : super(InitialState());

  static EventsCubit get(context) => BlocProvider.of(context);

  var selectedEvent = EventEnum.BIBLE;
  DateTime? selectedDate;
  var event = EventsModel();
  var title = "";
  List<UserModel> members = <UserModel>[];
  List<UserModel> servants = <UserModel>[];
  List<UserModel> admins = <UserModel>[];
  Map<String,List<UserModel>> group = {};
  TextEditingController titleController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  File? image;
  List<EventAttendanceModel> selectedMembers = [];
  List<ClassModel> classes = [];
  int currentIndex = 0;
  var userData = UserModel();

  final EventsUseCase eventsUseCase = EventsUseCase(EventsRepository());
  final GoogleDriveUploader googleDriveUploader = GoogleDriveUploader();
  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());

  void getAllMembers() async{
    members = CacheHelper.getMembers();
    servants = CacheHelper.getServants();
    admins = CacheHelper.getAdmins();
    classes = CacheHelper.getClasses();
    userData = CacheHelper.getUserData();
    group = groupBy();
    selectedMembers.clear();
    emit(GetAllMembersState());
  }

  void onRest(){
    selectedMembers.clear();
    group.values.elementAt(0).forEach((element) {
      element.checked = false;
    });
    group.values.elementAt(1).forEach((element) {
      element.checked = false;
    });
    group.values.elementAt(2).forEach((element) {
      element.checked = false;
    });
    group.values.elementAt(3).forEach((element) {
      element.checked = false;
      });
    group.values.elementAt(4).forEach((element) {
      element.checked = false;
    });
    group.values.elementAt(5).forEach((element) {
      element.checked = false;
      });
    group.values.elementAt(6).forEach((element) {
      element.checked = false;
    });
    group.values.elementAt(7).forEach((element) {
      element.checked = false;
    });
    emit(OnRest());
  }
  void onSelectEvent(value) {
    selectedEvent = value;
    emit(SelectEventState());
  }
  void onAddMember(UserModel member,int index){
    group.values.elementAt(currentIndex)[index].checked = true;
    selectedMembers.add(EventAttendanceModel(userId: member.uid, name: member.name));
    emit(OnAddMember());
  }

  void onRemoveMember(UserModel member,int index){
    group.values.elementAt(currentIndex)[index].checked = false;
    selectedMembers.removeAt(selectedMembers.indexWhere((element) => element.userId == member.uid));
    emit(OnAddMember());
  }

  Map<String,List<UserModel>> groupBy(){
    Map<String,List<UserModel>> map = {};
    for (var element in members) {
      if(map.containsKey(element.classId)){
        map[element.classId??""]?.add(element);
      }else{
        map[element.classId??""] = [element];
      }
    }
    return map;
  }

  void onBackDone(List<EventAttendanceModel> selectedMembers) {
    this.selectedMembers = selectedMembers;
    emit(OnBackDone());
  }

  void onSubmit() async {
    emit(OnLoading());
    event = event.copyWith(
      title: titleController.text,
      image: await googleDriveUploader.uploadFileToDrive(
        image!,
        'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
      date: selectedDate.toString(),
      attendance: [],
    );
    try {
      switch (selectedEvent) {
        case EventEnum.BIBLE:
          {
            String id = await eventsUseCase.addNewBibleEvent(
              event.copyWith(name: "bible"),
            );
            var events = CacheHelper.getEvents('bible');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'bible');
          }
        case EventEnum.DOCTRINE:
          {
            String id = await eventsUseCase.addNewDoctrineEvent(event.copyWith(name: "عقيدة"));
            var events = CacheHelper.getEvents('doctrine');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'doctrine');
          }
        case EventEnum.COPTIC:
          {
            String id = await eventsUseCase.addNewCopticEvent(event.copyWith(name: "قبطي"));
            var events = CacheHelper.getEvents('coptic');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'coptic');
          }
        case EventEnum.RITUAL:
          {
            String id = await eventsUseCase.addNewRitualEvent(event.copyWith(name: "طقس"));
            var events = CacheHelper.getEvents('ritual');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'ritual');
          }
        case EventEnum.CHOIR:
          {
            String id = await eventsUseCase.addNewChoirEvent(event.copyWith(name: "كورال"));
            var events = CacheHelper.getEvents('choir');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'choir');
          }
        case EventEnum.MELODIES:
          {
            String id = await eventsUseCase.addNewMelodiesEvent(event.copyWith(name: "الحان"));
            var events = CacheHelper.getEvents('melodies');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'melodies');
          }
        case EventEnum.CHESS:
          {
            String id = await eventsUseCase.addNewChessEvent(event.copyWith(name: "شطرنج"));
            var events = CacheHelper.getEvents('chess');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'chess');
          }
        case EventEnum.PINGPONG:
          {
            String id = await eventsUseCase.addNewPingPongEvent(event);
            var events = CacheHelper.getEvents('pingPong');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'pingPong');
          }
        case EventEnum.VOLLEYBALL:
          {
            String id = await eventsUseCase.addNewVolleyballEvent(
              event.copyWith(name: "volleyball"),
            );
            var events = CacheHelper.getEvents('volleyball');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'volleyball');
          }
        case EventEnum.FOOTBALL:
          {
            String id = await eventsUseCase.addNewFootballEvent(event.copyWith(name: "كورة قدم"));
            var events = CacheHelper.getEvents('football');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'football');
          }
      }
      await usersUseCase.updateApplyToAll(servants);
      // await usersUseCase.updateApplyToAll(members);
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    image = File(pickedFile.path);
    emit(PickImageState());
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (datePicked != null) {
      selectedDate = datePicked;
      event = event.copyWith(date: datePicked.toString());
    }
    emit(OnSelectDate());
  }

  String formatDate(DateTime dateTime, String lang) {
    String locale = lang == "en" ? "en_US" : "ar_SA";
    DateFormat dateFormat = DateFormat("EEEE d - MMM", locale);
    return dateFormat.format(dateTime);
  }


  Future<void> onEventAttendance(String event,String title)async{
    emit(OnLoading());
    try{
      for(var element in selectedMembers){
        try{
          await usersUseCase.addEventAttendance(element.userId ?? "", event, title);
          final user = members.firstWhere((user) => user.uid == element.userId);
          switch (title) {
            case "bible":{
              if (!user.bible!.contains(event)) {
                user.bible!.add(event);
              }
            }
            case "doctrine":{
              if (!user.doctrine!.contains(event)) {
                user.doctrine!.add(event);
              }
            }
            case "coptic": {
              if (!user.coptic!.contains(event)) {
                user.coptic!.add(event);
              }
            }
            case "ritual": {
              if (!user.ritual!.contains(event)) {
                user.ritual!.add(event);
              }
            }
            case "choir": {
              if (!user.choir!.contains(event)) {
                user.choir!.add(event);
              }
            }
            case "melodies": {
              if (!user.melodies!.contains(event)) {
                user.melodies!.add(event);
              }
            }
            case "chess": {
              if (!user.chess!.contains(event)) {
                user.chess!.add(event);
              }
            }
            case "pingPong": {
              if (!user.pingPong!.contains(event)) {
                user.pingPong!.add(event);
              }
            }
            case "volleyball": {
              if (!user.volleyball!.contains(event)) {
                user.volleyball!.add(event);
              }
            }
            case "football": {
              if (!user.football!.contains(event)) {
                user.football!.add(event);
              }
            }
            default:{}
          }
          await usersUseCase.updateApplyToAll(admins);
        }catch(e){
          emit(OnError(e.toString()));
        }
      }
      await CacheHelper.saveMembers(members);
    }catch(e){
      emit(OnError(e.toString()));
    }
    emit(OnSuccess());
  }
}
