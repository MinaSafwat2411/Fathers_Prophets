import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:fathers_prophets/presentation/cubit/chat/states/chat_states.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/chat/chat_model.dart';
import '../../../../data/models/chat/chat_preview_model.dart';
import '../../../../data/models/classes/class_model.dart';
import '../../../../data/models/classes/class_user_model.dart';
import '../../../../data/services/notification/firebase_notification_service.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  final dbUserChatRooms = FirebaseDatabase.instance.ref('userChatRooms');
  final dbChatRooms = FirebaseDatabase.instance.ref('chatRooms');

  List<ChatModel> chats = <ChatModel>[]; // Chat previews (last message from each room)
  List<ChatModel> chatsRoom = <ChatModel>[]; // Full chat room
  UserModel userData = UserModel();
  List<ClassUserModel> servants = <ClassUserModel>[];
  List<ClassModel> classes = <ClassModel>[];
  TextEditingController textController = TextEditingController();
  ChatPreviewModel chatPreview = ChatPreviewModel(
    name: '',
    chats: [],
    receiverUid: '',
    senderUid: '',
  );
  String fcmToken = '';

  void getUserData() {
    userData = CacheHelper.getUserData();
  }

  void getClasses() {
    classes = CacheHelper.getClasses();
    for (var item in classes) {
      servants.addAll(item.servants ?? []);
    }
  }

  String getUserNameByUid(String uid) {
    return servants.firstWhere((element) => element.uid == uid).name ?? '';
  }

  void listenToMyChats() {
    emit(ChatLoading());
    final ref = dbUserChatRooms.child(userData.uid ?? "");

    ref.onValue.listen((event) async {
      final roomIds = event.snapshot.children.map((e) => e.key).toList();
      final List<ChatModel> previews = [];

      for (var roomId in roomIds) {
        final roomRef = dbChatRooms.child(roomId!);
        final snapshot = await roomRef.get();

        if (snapshot.exists) {
          final messages = snapshot.children;
          if (messages.isNotEmpty) {
            final lastSnap = messages.last;
            final value = lastSnap.value as Map;
            final map = Map<String, dynamic>.from(value);
            previews.add(ChatModel.fromMap(map, lastSnap.key ?? ""));
          }
        }
      }

      previews.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      chats = previews;
      emit(ChatUpdated());
    }, onError: (e) {
      emit(ChatError(e.toString()));
    });
  }

  Future<void> clearChat(String senderUid, String receiverUid) async {
    final roomId = generateRoomId(senderUid, receiverUid);
    await dbChatRooms.child(roomId).remove();
  }

  Future<void> getFCMToken(String receiverUid) async {
    if (fcmToken == '') {
      final userSnap = await FirebaseFirestore.instance
          .collection(FirebaseEndpoints.users)
          .doc(receiverUid)
          .get();
      final userData = UserModel.fromJson(userSnap.data() as Map<String, dynamic>, userSnap.id);
      fcmToken = userData.fcmToken ?? '';
    }
  }

  Future<void> sendMessage(String senderUid, String receiverUid, String text) async {
    final roomId = generateRoomId(senderUid, receiverUid);
    final message = ChatModel(
      text: text,
      senderUid: senderUid,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: false,
      key: '',
    );

    final ref = FirebaseDatabase.instance.ref();
    await ref.child('chatRooms/$roomId').push().set(message.toMap());

    await ref.child('userChatRooms/$senderUid/$roomId').set(true);
    await ref.child('userChatRooms/$receiverUid/$roomId').set(true);
    await sendNotificationToReceiver(receiverUid, text);
    textController.clear();
  }

  Future<void> markAsRead(String roomId, String messageKey) async {
    await dbChatRooms.child(roomId).child(messageKey).update({'isRead': true});
  }

  Future<void> sendNotificationToReceiver(String receiverUid, String messageText) async {
    if (fcmToken == '') return;

    try {
      await FirebaseNotificationService.sendToToken(
        fcmToken: fcmToken,
        title: userData.name ?? "",
        body: messageText,
      );
    } catch (e) {
      debugPrint("❗ Notification Error: $e");
      emit(ChatError(e.toString()));
    }
  }

  void listenToRoom(String receiverUid) {
    emit(ChatLoading());
    final roomId = generateRoomId(userData.uid ?? "", receiverUid);
    final ref = dbChatRooms.child(roomId);

    ref.onValue.listen((event) async {
      final data = event.snapshot.children;
      final List<ChatModel> loadedChats = [];

      for (var snap in data) {
        final value = snap.value as Map;
        final map = Map<String, dynamic>.from(value);
        final chat = ChatModel.fromMap(map, snap.key ?? '');

        if (!chat.isRead && chat.senderUid != userData.uid) {
          await markAsRead(roomId, chat.key);
          chat.isRead = true;
          await Future.delayed(Duration(milliseconds: 200));
          listenToMyChats();
        }

        loadedChats.add(chat);
      }

      loadedChats.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      chatsRoom = loadedChats;
      emit(ChatUpdated());
    }, onError: (e) {
      emit(ChatError(e.toString()));
    });
  }

  String generateRoomId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }
  
}
