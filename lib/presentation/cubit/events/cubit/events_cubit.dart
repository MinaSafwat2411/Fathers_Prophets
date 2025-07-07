import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fathers_prophets/data/models/classes/class_model.dart';
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
  List<UserModel> members = <UserModel>[];
  List<UserModel> servants = <UserModel>[];
  List<UserModel> admins = <UserModel>[];
  TextEditingController titleController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  File? image;
  List<AttendanceEventModel> selectedMembers = [];
  List<ClassModel> classes = [];
  int currentIndex = 0;
  var userData = UserModel();

  final EventsUseCase eventsUseCase = EventsUseCase(EventsRepository());
  final EventAttendanceUseCase eventsAttendanceUseCase = EventAttendanceUseCase(EventAttendanceRepository());
  final GoogleDriveUploader googleDriveUploader = GoogleDriveUploader();
  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());

  void getAllMembers() async{
    classes = CacheHelper.getClasses();
    userData = CacheHelper.getUserData();
    selectedMembers.clear();
    emit(GetAllMembersState());
  }

  List<UserModel> getMembers(String id){
    return CacheHelper.getMembersByClassId(id);
  }

  void onRest(){
    selectedMembers.clear();
    emit(OnRest());
  }
  void onSelectEvent(value) {
    selectedEvent = value;
    emit(SelectEventState());
  }
  void onAddMember(UserModel member){
    selectedMembers.add(AttendanceEventModel(userId: member.uid, name: member.name));
    emit(OnAddMember());
  }

  void onRemoveMember(UserModel member){
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
      image: await googleDriveUploader.uploadFileToDrive(
        image!=null?image!:await getDefaultImageFile(),
        'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
      date: selectedDate.toString(),
    );
    try {
      switch (selectedEvent) {
        case EventEnum.BIBLE:
          {
            String id = await eventsUseCase.addNewBibleEvent(
              event.copyWith(name: "كتاب مقدس"),
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
            String id = await eventsUseCase.addNewPingPongEvent(event.copyWith(
              name: "بينج بونج"
            ));
            var events = CacheHelper.getEvents('pingPong');
            events.add(event.copyWith(docId: id));
            await CacheHelper.saveEvents(events, 'pingPong');
          }
        case EventEnum.VOLLEYBALL:
          {
            String id = await eventsUseCase.addNewVolleyballEvent(
              event.copyWith(name: "كورة طائرة"),
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
          case EventEnum.PRAISE:
            {
              String id  =await eventsUseCase.addNewPraiseEvent(event.copyWith(name: "تسبحة"));
              var events = CacheHelper.getEvents('praise');
              events.add(event.copyWith(docId: id));
              await CacheHelper.saveEvents(events, 'praise');
            }
          case EventEnum.PRAY:{
            String id = await eventsUseCase.addNewPrayEvent(event.copyWith(name:  "صلاة"));
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
    var index =eventModel.index??-1;
    try{
      for(var element in selectedMembers){
        try{
          await eventsAttendanceUseCase.addEventAttendance(element.userId ?? "", event, title);
        }catch(e){
          emit(OnError(e.toString()));
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
          await eventsUseCase.addFootballAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var football = CacheHelper.getEvents('football');
          football[index] = this.event;
          await CacheHelper.saveEvents(football, 'football');
          break;
        }
        case 'volleyball':{
          await eventsUseCase.addVolleyballAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var volleyball = CacheHelper.getEvents('volleyball');
          volleyball[index] = this.event;
          await CacheHelper.saveEvents(volleyball, 'volleyball');
          break;
        }
        case 'bible':{
          await eventsUseCase.addBibleAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var bible = CacheHelper.getEvents('bible');
          bible[index] = this.event;
          await CacheHelper.saveEvents(bible, 'bible');
          break;
        }
        case 'ritual':{
          await eventsUseCase.addRitualAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var ritual = CacheHelper.getEvents('ritual');
          ritual[index] = this.event;
          await CacheHelper.saveEvents(ritual, 'ritual');
          break;
        }
        case 'doctrine':{
          await eventsUseCase.addDoctrineAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var doctrine = CacheHelper.getEvents('doctrine');
          doctrine[index] = this.event;
          await CacheHelper.saveEvents(doctrine, 'doctrine');
          break;
        }
        case 'coptic':{
          await eventsUseCase.addCopticAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var coptic = CacheHelper.getEvents('coptic');
          coptic[index] = this.event;
          await CacheHelper.saveEvents(coptic, 'coptic');
          break;
        }
        case 'choir':{
          await eventsUseCase.addChoirAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var choir = CacheHelper.getEvents('choir');
          choir[index] = this.event;
          await CacheHelper.saveEvents(choir, 'choir');
          break;
        }
        case 'chess':{
          await eventsUseCase.addChessAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var chess = CacheHelper.getEvents('chess');
          chess[index] = this.event;
          await CacheHelper.saveEvents(chess, 'chess');
          break;
        }
        case 'pingPong':{
          await eventsUseCase.addPingPongAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var pingPong = CacheHelper.getEvents('pingPong');
          pingPong[index] = this.event;
          await CacheHelper.saveEvents(pingPong, 'pingPong');
          break;
        }
        case 'melodies':{
          await eventsUseCase.addMelodiesAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var melodies = CacheHelper.getEvents('melodies');
          melodies[index] = this.event;
          await CacheHelper.saveEvents(melodies, 'melodies');
          break;
        }
        case 'pray':{
          await eventsUseCase.addPrayAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var pray = CacheHelper.getEvents('pray');
          pray[index] = this.event;
          await CacheHelper.saveEvents(pray, 'pray');
          break;
        }
        case 'praise':{
          await eventsUseCase.addPraiseAttendance(selectedMembers.map((e) => e.name??"").toList(), event);
          var praise = CacheHelper.getEvents('praise');
          praise[index] = this.event;
          await CacheHelper.saveEvents(praise, 'praise');
          break;
        }
        default: break;
      }
      await CacheHelper.saveMembers(members);
    }catch(e){
      emit(OnError(e.toString()));
    }
    emit(OnSuccess());
  }
}
