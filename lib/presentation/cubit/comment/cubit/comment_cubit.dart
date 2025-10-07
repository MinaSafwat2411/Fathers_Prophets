import 'dart:async';

import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/comment/comment_model.dart';
import '../../../../data/models/eventattendance/event_attendance_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/eventattendance/event_attendance_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/cache/i_cache_helper.dart';
import '../../../../domain/usecases/eventattendance/event_attendance_use_case.dart';
import '../../../../domain/usecases/eventattendance/i_event_attendance_use_case.dart';
import '../../../../domain/usecases/users/i_users_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/comment_states.dart';

class CommentCubit extends Cubit<CommentStates> {
  CommentCubit(this.eventsAttendanceUseCase,this.usersUseCase, this.cacheHelper) : super(CommentInitial());
  final ICacheHelper cacheHelper;

  static CommentCubit get(context) => BlocProvider.of(context);
  TextEditingController commentController = TextEditingController();
  int football=0;
  int volleyball=0;
  int pingPong=0;
  int chess=0;
  int melodies=0;
  int choir=0;
  int ritual=0;
  int coptic=0;
  int doctrine=0;
  int bible=0;
  int pray=0;
  int praise=0;
  int mahrgan=0;

  final IEventAttendanceUseCase eventsAttendanceUseCase;
  final IUsersUseCase usersUseCase;

  final _db = FirebaseDatabase.instance.ref();
  StreamSubscription<DatabaseEvent>? commentSub;
  List<ClassModel> classes = <ClassModel>[];
  List<CommentModel> comments = <CommentModel>[];
  EventAttendanceModel attendance= EventAttendanceModel();
  var user = UserModel();

  void getUserData(String uid)async{
    emit(OnLoading());
    try{
      football = cacheHelper.getEvents('football').length;
      volleyball = cacheHelper.getEvents('volleyball').length;
      pingPong = cacheHelper.getEvents('pingpong').length;
      chess = cacheHelper.getEvents('chess').length;
      melodies = cacheHelper.getEvents('melodies').length;
      choir = cacheHelper.getEvents('choir').length;
      ritual = cacheHelper.getEvents('ritual').length;
      coptic = cacheHelper.getEvents('coptic').length;
      doctrine = cacheHelper.getEvents('doctrine').length;
      bible = cacheHelper.getEvents('bible').length;
      pray = cacheHelper.getEvents('pray').length;
      praise = cacheHelper.getEvents('praise').length;
      mahrgan = cacheHelper.getEvents('mahrgan').length;
      user = (await usersUseCase.getUserData(uid)??UserModel());
      getAttendance(uid);
      listenToComments(uid);
      emit(OnSuccess());
    }catch(e){
      emit(OnError(e.toString()));
    }
    emit(OnSuccess());
  }
  void listenToComments(String userId) {
    classes = cacheHelper.getClasses();
    emit(CommentLoading());
    commentSub = _db.child("comments").onValue.listen((event) {
      final data = event.snapshot.value;
      if (data == null || data is! Map) {
        emit(CommentLoaded([]));
        return;
      }

      final comments = (data).entries.map((entry) {
        final value = Map<String, dynamic>.from(entry.value);
        return CommentModel.fromJson(value, entry.key);
      }).toList();

      comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      comments.removeWhere((comment) => comment.authorId != userId);
      this.comments = comments;
      emit(CommentLoaded(comments));
    }, onError: (error) {
      emit(CommentError(error.toString()));
    });
  }
  Future<void> addComment(CommentModel comment) async {
    final commentRef = _db.child("comments").push();
    await commentRef.set(comment.toJson());
    commentController.clear();
  }

  Future<void> deleteComment(String commentId) async {
    await _db.child("comments").child(commentId).remove();
    comments.removeWhere((comment) => comment.id == commentId);
    emit(CommentDeleted());
  }

  Future<void> updateComment(CommentModel comment) async {
    await _db.child("comments").child(comment.id??"").update(comment.toJson());
    commentController.clear();
    comments.removeWhere((c) => c.id == comment.id);
    comments.add(comment);
    emit(CommentUpdated());
  }

  Future<void> getAttendance(String userId) async {
    emit(OnLoading());
    try{
      final attendance = await eventsAttendanceUseCase.getEventAttendanceById(userId);
      this.attendance = attendance??EventAttendanceModel();
      emit(OnSuccess());
    }catch(e){
      emit(OnError(e.toString()));
    }
  }
  @override
  Future<void> close() {
    commentSub?.cancel();
    return super.close();
  }
}