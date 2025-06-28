import 'dart:async';

import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/comment/comment_model.dart';
import '../states/comment_states.dart';

class CommentCubit extends Cubit<CommentStates> {
  CommentCubit() : super(CommentInitial());

  static CommentCubit get(context) => BlocProvider.of(context);
  TextEditingController commentController = TextEditingController();

  final _db = FirebaseDatabase.instance.ref();
  StreamSubscription<DatabaseEvent>? commentSub;
  List<ClassModel> classes = <ClassModel>[];

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

  @override
  Future<void> close() {
    commentSub?.cancel();
    return super.close();
  }
}