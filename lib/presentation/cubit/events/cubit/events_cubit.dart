import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/repositories/eventattendance/event_attendance_repository.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:fathers_prophets/domain/usecases/users/users_use_case.dart';
import 'package:fathers_prophets/presentation/screens/add_event_screen/event_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/firebase_endpoints.dart';
import '../../../../data/models/events/event_attendance_model.dart';
import '../../../../data/repositories/events/events_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/google_drive_service.dart';
import '../../../../domain/usecases/eventattendance/event_attendance_use_case.dart';
import '../../../../domain/usecases/events/events_use_case.dart';
import '../states/events_states.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class EventsCubit extends Cubit<EventsStates> {
  EventsCubit() : super(InitialState());

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

  final EventsUseCase eventsUseCase = EventsUseCase(EventsRepository());
  final EventAttendanceUseCase eventsAttendanceUseCase = EventAttendanceUseCase(EventAttendanceRepository());
  final GoogleDriveUploader googleDriveUploader = GoogleDriveUploader();
  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());

  void getAllMembers() async{
    classes = CacheHelper.getClasses();
    filteredClasses = classes;
    userData = CacheHelper.getUserData();
    selectedMembers.clear();
    emit(GetAllMembersState());
  }

  void onRefresh(){
    classes = CacheHelper.getClasses();
    filteredClasses = classes;
    userData = CacheHelper.getUserData();
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
            var events = CacheHelper.getEvents('bible');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'bible');
          }
        case EventEnum.DOCTRINE:
          {
            event = event.copyWith(name: "عقيدة");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.doctrine);
            var events = CacheHelper.getEvents('doctrine');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'doctrine');
          }
        case EventEnum.COPTIC:
          {
            event = event.copyWith(name: "قبطي");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.coptic);
            var events = CacheHelper.getEvents('coptic');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'coptic');
          }
        case EventEnum.RITUAL:
          {
            event = event.copyWith(name: "طقس");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.ritual);
            var events = CacheHelper.getEvents('ritual');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'ritual');
          }
        case EventEnum.CHOIR:
          {
            event = event.copyWith(name: "كورال");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.choir);
            var events = CacheHelper.getEvents('choir');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'choir');
          }
        case EventEnum.MELODIES:
          {
            event = event.copyWith(name: "الحان");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.melodies);
            var events = CacheHelper.getEvents('melodies');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'melodies');
          }
        case EventEnum.CHESS:
          {
            event = event.copyWith(name: "شطرنج");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.chess);
            var events = CacheHelper.getEvents('chess');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'chess');
          }
        case EventEnum.PINGPONG:
          {
            event = event.copyWith(name: "بينج بونج");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.pingPong);
            var events = CacheHelper.getEvents('pingPong');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'pingPong');
          }
        case EventEnum.VOLLEYBALL:
          {
            event= event.copyWith(name: "كورة طائرة");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.volleyball);
            var events = CacheHelper.getEvents('volleyball');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'volleyball');
          }
        case EventEnum.FOOTBALL:
          {
            event= event.copyWith(name: "كورة قدم");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.football);
            var events = CacheHelper.getEvents('football');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'football');
          }
          case EventEnum.PRAISE:
            {
              event= event.copyWith(name: "تسبحة");
              String id  =await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.praise);
              var events = CacheHelper.getEvents('praise');
              events.add(event.copyWith(docId: id));
              await CacheHelper.saveEvents(events, 'praise');
            }
          case EventEnum.PRAY:{
            event =event.copyWith(name:  "صلاة");
            String id = await eventsUseCase.addNewEventByName(event,FirebaseEndpoints.pray);
            var events = CacheHelper.getEvents('pray');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'pray');
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
          var football = CacheHelper.getEvents('football');
          var index = football.indexWhere((element) => element.docId == event);
          football[index] = this.event;
          await CacheHelper.saveEvents(football, 'football');
          break;
        }
        case 'volleyball':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.volleyball);
          var volleyball = CacheHelper.getEvents('volleyball');
          var index = volleyball.indexWhere((element) => element.docId == event);
          volleyball[index] = this.event;
          await CacheHelper.saveEvents(volleyball, 'volleyball');
          break;
        }
        case 'bible':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.bible);
          var bible = CacheHelper.getEvents('bible');
          var index = bible.indexWhere((element) => element.docId == event);
          bible[index] = this.event;
          await CacheHelper.saveEvents(bible, 'bible');
          break;
        }
        case 'ritual':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.ritual);
          var ritual = CacheHelper.getEvents('ritual');
          var index = ritual.indexWhere((element) => element.docId == event);
          ritual[index] = this.event;
          await CacheHelper.saveEvents(ritual, 'ritual');
          break;
        }
        case 'doctrine':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.doctrine);
          var doctrine = CacheHelper.getEvents('doctrine');
          var index = doctrine.indexWhere((element) => element.docId == event);
          doctrine[index] = this.event;
          await CacheHelper.saveEvents(doctrine, 'doctrine');
          break;
        }
        case 'coptic':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.coptic);
          var coptic = CacheHelper.getEvents('coptic');
          var index = coptic.indexWhere((element) => element.docId == event);
          coptic[index] = this.event;
          await CacheHelper.saveEvents(coptic, 'coptic');
          break;
        }
        case 'choir':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.choir);
          var choir = CacheHelper.getEvents('choir');
          var index = choir.indexWhere((element) => element.docId == event);
          choir[index] = this.event;
          await CacheHelper.saveEvents(choir, 'choir');
          break;
        }
        case 'chess':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.chess);
          var chess = CacheHelper.getEvents('chess');
          var index = chess.indexWhere((element) => element.docId == event);
          chess[index] = this.event;
          await CacheHelper.saveEvents(chess, 'chess');
          break;
        }
        case 'pingPong':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.pingPong);
          var pingPong = CacheHelper.getEvents('pingPong');
          var index = pingPong.indexWhere((element) => element.docId == event);
          pingPong[index] = this.event;
          await CacheHelper.saveEvents(pingPong, 'pingPong');
          break;
        }
        case 'melodies':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.melodies);
          var melodies = CacheHelper.getEvents('melodies');
          var index = melodies.indexWhere((element) => element.docId == event);
          melodies[index] = this.event;
          await CacheHelper.saveEvents(melodies, 'melodies');
          break;
        }
        case 'pray':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.pray);
          var pray = CacheHelper.getEvents('pray');
          var index = pray.indexWhere((element) => element.docId == event);
          pray[index] = this.event;
          await CacheHelper.saveEvents(pray, 'pray');
          break;
        }
        case 'praise':{
          await eventsUseCase.addEventAttendance(selectedMembers.map((e) => e.name??"").toList(), event,FirebaseEndpoints.praise);
          var praise = CacheHelper.getEvents('praise');
          var index = praise.indexWhere((element) => element.docId == event);
          praise[index] = this.event;
          await CacheHelper.saveEvents(praise, 'praise');
          break;
        }
        default: break;
      }
    }catch(e){
      print(e.toString());
      emit(OnError(e.toString()));
    }
    emit(OnSuccess());
  }
}
