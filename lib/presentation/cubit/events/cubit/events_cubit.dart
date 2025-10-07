import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/presentation/screens/add_event_screen/event_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/firebase_endpoints.dart';
import '../../../../data/models/events/event_attendance_model.dart';
import '../../../../data/services/cache/i_cache_helper.dart';
import '../../../../data/services/drive/i_google_drive_service.dart';
import '../../../../domain/usecases/eventattendance/i_event_attendance_use_case.dart';
import '../../../../domain/usecases/events/i_events_use_case.dart';
import '../../../../domain/usecases/users/i_users_use_case.dart';
import '../states/events_states.dart';

class EventsCubit extends Cubit<EventsStates> {
  EventsCubit(this.eventsUseCase,this.eventsAttendanceUseCase,this.usersUseCase,this.googleDriveUploader,this.cacheHelper) : super(InitialState());

  final ICacheHelper cacheHelper;

  static EventsCubit get(context) => BlocProvider.of(context);

  var selectedEvent = EventEnum.BIBLE;
  DateTime? selectedDate;
  var event = EventsModel();
  var title = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  File? image;
  List<AttendanceEventModel> selectedMembers = [];
  List<ClassModel> classes = <ClassModel>[];
  List<ClassModel> filteredClasses = <ClassModel>[];
  int currentIndex = 0;
  var userData = UserModel();

  final IEventsUseCase eventsUseCase;
  final IEventAttendanceUseCase eventsAttendanceUseCase;
  final IGoogleDriveUploader googleDriveUploader;
  final IUsersUseCase usersUseCase;

  void getAllMembers() async{
    classes = cacheHelper.getClasses();
    filteredClasses = classes;
    userData = cacheHelper.getUserData();
    selectedMembers.clear();
    emit(GetAllMembersState());
  }

  void onRefresh(){
    classes = cacheHelper.getClasses();
    filteredClasses = classes;
    userData = cacheHelper.getUserData();
    searchController.clear();
    emit(GetAllMembersState());
  }


  void onSearch(String value) async {
    searchController.text = value;
    final query = value.trim().toLowerCase();

    filteredClasses = classes
        .map((classModel) {
      final matchedMembers = classModel.members
          ?.where((member) =>
      member.name?.toLowerCase().contains(query) ?? false)
          .toList();

      if (matchedMembers != null && matchedMembers.isNotEmpty) {
        return ClassModel(
          name: classModel.name,
          docId: classModel.docId,
          members: matchedMembers,
        );
      }
      return null;
    })
        .whereType<ClassModel>() // removes any nulls
        .toList();

    emit(OnSearch());
  }


  void onRest(){
    selectedMembers.clear();
    emit(OnRest());
  }
  void onSelectEvent(value) {
    selectedEvent = value;
    emit(SelectEventState());
  }
  void onAddMember(ClassUserModel member){
    selectedMembers.add(AttendanceEventModel(userId: member.uid, name: member.name));
    emit(OnAddMember());
  }

  void onRemoveMember(ClassUserModel member){
    selectedMembers.removeAt(selectedMembers.indexWhere((element) => element.userId == member.uid));
    emit(OnAddMember());
  }

  void onBackDone(List<AttendanceEventModel> selectedMembers) {
    this.selectedMembers = selectedMembers;
    emit(OnBackDone());
  }

  Future<File> getDefaultImageFile() async {
    final byteData = await rootBundle.load('assets/images/logo_light.png');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/default_image.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  void onSubmit() async {
    emit(OnLoading());
   
    event = event.copyWith(
      title: titleController.text,
      image: image != null?await googleDriveUploader.uploadFileToDrive(
        image!=null?image!:await getDefaultImageFile(),
        'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ):'',
      date: selectedDate.toString(),
    );
    try {
      switch (selectedEvent) {
        case EventEnum.BIBLE:
          {
            event = event.copyWith(name: "كتاب مقدس");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.bible);
            var events = cacheHelper.getEvents('bible');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'bible');
          }
        case EventEnum.DOCTRINE:
          {
            event = event.copyWith(name: "عقيدة");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.doctrine);
            var events = cacheHelper.getEvents('doctrine');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'doctrine');
          }
        case EventEnum.COPTIC:
          {
            event = event.copyWith(name: "قبطي");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.coptic);
            var events = cacheHelper.getEvents('coptic');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'coptic');
          }
        case EventEnum.RITUAL:
          {
            event = event.copyWith(name: "طقس");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.ritual);
            var events = cacheHelper.getEvents('ritual');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'ritual');
          }
        case EventEnum.CHOIR:
          {
            event = event.copyWith(name: "كورال");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.choir);
            var events = cacheHelper.getEvents('choir');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'choir');
          }
        case EventEnum.MELODIES:
          {
            event = event.copyWith(name: "الحان");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.melodies);
            var events = cacheHelper.getEvents('melodies');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'melodies');
          }
        case EventEnum.CHESS:
          {
            event = event.copyWith(name: "شطرنج");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.chess);
            var events = cacheHelper.getEvents('chess');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'chess');
          }
        case EventEnum.PINGPONG:
          {
            event = event.copyWith(name: "بينج بونج");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.pingPong);
            var events = cacheHelper.getEvents('pingPong');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'pingPong');
          }
        case EventEnum.VOLLEYBALL:
          {
            event= event.copyWith(name: "كورة طائرة");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.volleyball);
            var events = cacheHelper.getEvents('volleyball');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'volleyball');
          }
        case EventEnum.FOOTBALL:
          {
            event= event.copyWith(name: "كورة قدم");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.football);
            var events = cacheHelper.getEvents('football');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'football');
          }
          case EventEnum.PRAISE:
            {
              event= event.copyWith(name: "تسبحة");
              String id  =await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.praise);
              var events = cacheHelper.getEvents('praise');
              events.add(event.copyWith(docId: id));
              await cacheHelper.saveEvents(events, 'praise');
            }
          case EventEnum.PRAY:{
            event =event.copyWith(name:  "صلاة");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.pray);
            var events = cacheHelper.getEvents('pray');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'pray');
          }
          case EventEnum.MAHRGAN:{
            event =event.copyWith(name:  "مهرجان");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.mahrgan);
            var events = cacheHelper.getEvents('mahrgan');
            events.add(event.copyWith(docId: id));
            await cacheHelper.saveEvents(events, 'mahrgan');
          }
      }
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


  Future<void> onEventAttendance(String event,String title,EventsModel eventModel)async{
    emit(OnLoading());
    try{
      for(var element in selectedMembers){
        try{
          await eventsAttendanceUseCase.addEventAttendance(element.userId ?? "", event, title);
        }catch(e){
          emit(OnError("${element.name} didn't attend"));
        }
      }
      final currentAttendance = eventModel.attendance ?? [];
      final newNames = selectedMembers
          .map((e) => e.name ?? "")
          .where((name) => name.isNotEmpty && !currentAttendance.contains(name))
          .toList();
      this.event = eventModel.copyWith(
        attendance: [...currentAttendance, ...newNames],
      );
      switch(title){
        case 'football':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.football);
          var football = cacheHelper.getEvents('football');
          var index = football.indexWhere((element) => element.docId == event);
          football[index] = this.event;
          await cacheHelper.saveEvents(football, 'football');
          break;
        }
        case 'volleyball':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.volleyball);
          var volleyball = cacheHelper.getEvents('volleyball');
          var index = volleyball.indexWhere((element) => element.docId == event);
          volleyball[index] = this.event;
          await cacheHelper.saveEvents(volleyball, 'volleyball');
          break;
        }
        case 'bible':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.bible);
          var bible = cacheHelper.getEvents('bible');
          var index = bible.indexWhere((element) => element.docId == event);
          bible[index] = this.event;
          await cacheHelper.saveEvents(bible, 'bible');
          break;
        }
        case 'ritual':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.ritual);
          var ritual = cacheHelper.getEvents('ritual');
          var index = ritual.indexWhere((element) => element.docId == event);
          ritual[index] = this.event;
          await cacheHelper.saveEvents(ritual, 'ritual');
          break;
        }
        case 'doctrine':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.doctrine);
          var doctrine = cacheHelper.getEvents('doctrine');
          var index = doctrine.indexWhere((element) => element.docId == event);
          doctrine[index] = this.event;
          await cacheHelper.saveEvents(doctrine, 'doctrine');
          break;
        }
        case 'coptic':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.coptic);
          var coptic = cacheHelper.getEvents('coptic');
          var index = coptic.indexWhere((element) => element.docId == event);
          coptic[index] = this.event;
          await cacheHelper.saveEvents(coptic, 'coptic');
          break;
        }
        case 'choir':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.choir);
          var choir = cacheHelper.getEvents('choir');
          var index = choir.indexWhere((element) => element.docId == event);
          choir[index] = this.event;
          await cacheHelper.saveEvents(choir, 'choir');
          break;
        }
        case 'chess':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.chess);
          var chess = cacheHelper.getEvents('chess');
          var index = chess.indexWhere((element) => element.docId == event);
          chess[index] = this.event;
          await cacheHelper.saveEvents(chess, 'chess');
          break;
        }
        case 'pingPong':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.pingPong);
          var pingPong = cacheHelper.getEvents('pingPong');
          var index = pingPong.indexWhere((element) => element.docId == event);
          pingPong[index] = this.event;
          await cacheHelper.saveEvents(pingPong, 'pingPong');
          break;
        }
        case 'melodies':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.melodies);
          var melodies = cacheHelper.getEvents('melodies');
          var index = melodies.indexWhere((element) => element.docId == event);
          melodies[index] = this.event;
          await cacheHelper.saveEvents(melodies, 'melodies');
          break;
        }
        case 'pray':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.pray);
          var pray = cacheHelper.getEvents('pray');
          var index = pray.indexWhere((element) => element.docId == event);
          pray[index] = this.event;
          await cacheHelper.saveEvents(pray, 'pray');
          break;
        }
        case 'praise':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.praise);
          var praise = cacheHelper.getEvents('praise');
          var index = praise.indexWhere((element) => element.docId == event);
          praise[index] = this.event;
          await cacheHelper.saveEvents(praise, 'praise');
          break;
        }
        case 'mahrgan':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.mahrgan);
          var mahrgan = cacheHelper.getEvents('mahrgan');
          var index = mahrgan.indexWhere((element) => element.docId == event);
          mahrgan[index] = this.event;
          await cacheHelper.saveEvents(mahrgan, 'mahrgan');
        }
        default: break;
      }
    }catch(e){
      emit(OnError(e.toString()));
    }
    emit(OnSuccess());
  }
}
