import 'dart:async';

import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/comment/comment_model.dart';
import '../../../../data/models/eventattendance/event_attendance_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/eventattendance/event_attendance_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../domain/usecases/eventattendance/event_attendance_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/comment_states.dart';

class CommentCubit extends Cubit<CommentStates> {
  CommentCubit() : super(CommentInitial());

  static CommentCubit get(context) => BlocProvider.of(context);
  TextEditingController commentController = TextEditingController();

  final EventAttendanceUseCase eventsAttendanceUseCase = EventAttendanceUseCase(EventAttendanceRepository());

  final _db = FirebaseDatabase.instance.ref();
  StreamSubscription<DatabaseEvent>? commentSub;
  List<ClassModel> classes = <ClassModel>[];
  EventAttendanceModel attendance= EventAttendanceModel();
  List<CommentModel> comments = <CommentModel>[];
  UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  var user = UserModel();

  void getUserData(String uid)async{
    emit(OnLoading());
    try{
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
    classes = CacheHelper.getClasses();
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