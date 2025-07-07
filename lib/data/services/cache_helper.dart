import 'dart:convert';

import 'package:fathers_prophets/data/models/quizzes/quiz_answers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/classes/class_model.dart';
import '../models/events/events_model.dart';
import '../models/quizzes/quizzes_model.dart';
import '../models/users/users_model.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;
  static init()async
  {
    sharedPreferences= await SharedPreferences.getInstance();
  }

  static dynamic getData({
    @required String? key,
  }){
    return  sharedPreferences!.get(key!);
  }

  static Future<bool> saveIntList({
    @required String? key,
    @required List<int>? value,
  }) async {
    List<String> stringList = value!.map((i) => i.toString()).toList();
    return await sharedPreferences!.setStringList(key!, stringList);
  }

  static List<int>? getIntList({
    @required String? key,
  }) {
    List<String>? stringList = sharedPreferences!.getStringList(key!);
    return stringList?.map((i) => int.parse(i)).toList();
  }

  static Future<bool> saveData({
    @required String? key,
    @required dynamic value,
  })async
  {
    if (value is bool) return await sharedPreferences!.setBool(key!, value);
    if (value is String) return await sharedPreferences!.setString(key!, value);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is double) return await sharedPreferences!.setDouble(key!, value);
    if (value is List<String>) return await sharedPreferences!.setStringList(key!, value);
    if (value is List<int>) return await saveIntList(key: key, value: value);
    if (value is Map<String, dynamic>) return await sharedPreferences!.setString(key!, value.toString());
    throw ArgumentError('Invalid type');
  }
  static Future<void> saveServants(List<UserModel?> servants) async {
    String jsonString = jsonEncode(servants.map((servant) => servant?.toJson()).toList());
    await sharedPreferences?.setString('users', jsonString);
  }
  static List<UserModel> getServants() {
    String? jsonString = sharedPreferences?.getString('users');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => UserModel.fromJson(json,json['uid'])).toList();
    } else {
      return [];
    }
  }

  static Future<bool> removeServants() async {
    return await sharedPreferences!.remove('users');
  }
  static Future<bool> saveServantsByClassId(List<UserModel?> servants,String classId) async {
    String jsonString = jsonEncode(servants.map((servant) => servant?.toJson()).toList());
    await sharedPreferences?.setString(classId, jsonString);
    return true;
  }

  static Future<bool> removeServantsByClassId(String classId) async {
    return await sharedPreferences!.remove(classId);
  }

  static List<UserModel> getServantsByClassId(String classId) {
    String? jsonString = sharedPreferences?.getString(classId);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => UserModel.fromJson(json,json['uid'])).toList();
    } else {
      return [];
    }
  }
  static Future<bool> saveAdmins(List<UserModel?> admins) async {
    String jsonString = jsonEncode(admins.map((admin) => admin?.toJson()).toList());
    await sharedPreferences?.setString('admins', jsonString);
    return true;
  }

  static List<UserModel> getAdmins(){
    String? jsonString = sharedPreferences?.getString('admins');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => UserModel.fromJson(json,json['uid'])).toList();
    } else {
      return [];
    }
  }
  static Future<bool> removeAdmins() async {
    return await sharedPreferences!.remove('admins');
  }


  static Future<bool> saveClassByClassId(ClassModel classModel,String classId) async {
    String jsonString = jsonEncode(classModel.toJson());
    await sharedPreferences?.setString(classId, jsonString);
    return true;
  }

  static ClassModel getClassByClassId(String classId) {
    String? jsonString = sharedPreferences?.getString(classId);
    if (jsonString == null) {
      return ClassModel(name: '', docId: '');
    }
    final Map<String, dynamic> json = jsonDecode(jsonString) as Map<String, dynamic>;
    return ClassModel.fromJson(json,classId);
  }

  static Future<bool> removeClassByClassId(String classId) async {
    return await sharedPreferences!.remove(classId);
  }

  static Future<bool> saveClasses(List<ClassModel?> classes) async {
    String jsonString = jsonEncode(
        classes.map((classModel) => classModel?.toJson()).toList());
    await sharedPreferences?.setString('classes', jsonString);
    return true;
  }

  static List<ClassModel> getClasses() {
    String? jsonString = sharedPreferences?.getString('classes');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => ClassModel.fromJson(json,json['docId'])).toList();
    } else {
      return [];
    }
  }

  static Future<bool> removeClasses() async {
    return await sharedPreferences!.remove('classes');
  }

  static Future<bool> saveMembersByClassId(List<UserModel> members, String classId) async {
    final List<Map<String, dynamic>> jsonList = members.map((m) => m.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    return await sharedPreferences!.setString(classId, jsonString);
  }
  static Future<bool> removeMembersByClassId(String classId) async {
    return await sharedPreferences!.remove(classId);
  }

  static List<UserModel> getMembersByClassId(String classId) {
    final String? jsonString = sharedPreferences?.getString(classId);
    if (jsonString == null) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => UserModel.fromJson(json as Map<String, dynamic>,json['uid']))
        .toList();
  }
  static Future<bool> saveMembers(List<UserModel?> members) async {
    String jsonString = jsonEncode(
        members.map((memberModel) => memberModel?.toJson()).toList());
    await sharedPreferences?.setString('members', jsonString);
    return true;
  }

  static List<UserModel> getMembers()  {
    String? jsonString = sharedPreferences?.getString('members');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => UserModel.fromJson(json,json['uid'])).toList();
    } else {
      return [];
    }
  }

  static Future<bool> removeMembers() async {
    return await sharedPreferences!.remove('members');
  }

  static Future<bool> saveQuizzes(List<QuizzesModel?> quizzes) async {
    String jsonString = jsonEncode(
        quizzes.map((quizzesModel) => quizzesModel?.toJson()).toList());
    await sharedPreferences?.setString('quizzes', jsonString);
    return true;
  }

  static List<QuizzesModel> getQuizzes() {
    String? jsonString = sharedPreferences?.getString('quizzes');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => QuizzesModel.fromJson(json,json['docId'])).toList();
    } else {
      return [];
    }
  }

  static Future<bool> saveUserData(UserModel user) async {
    String jsonString = jsonEncode(user.toJson());
    await sharedPreferences?.setString('user', jsonString);
    return true;
  }

  static UserModel getUserData(){
    String? jsonString = sharedPreferences?.getString('user');
    if (jsonString != null) {
      dynamic json = jsonDecode(jsonString);
      return UserModel.fromJson(json,json['uid']);
    } else {
      return UserModel();
    }
  }

  static Future<bool> removeUserData() async {
    return await sharedPreferences!.remove('user');
  }

  static Future<bool> saveClassData(ClassModel classModel) async {
    String jsonString = jsonEncode(classModel.toJson());
    await sharedPreferences?.setString('class', jsonString);
    return true;
  }

  static ClassModel getClass(){
    String? jsonString = sharedPreferences?.getString('class');
    if (jsonString != null) {
      dynamic json = jsonDecode(jsonString);
      return ClassModel.fromJson(json,json['docId']);
    } else {
      return ClassModel(
        name: '',
        docId: '',
      );
    }
  }

  static Future<bool> saveQuizzesData(QuizzesModel quizzesModel) async {
    String jsonString = jsonEncode(quizzesModel.toJson());
    await sharedPreferences?.setString('quizzes', jsonString);
    return true;
  }

  static Future<bool> saveQuizAnswers(QuizAnswers quizAnswers) async{
    String jsonString = jsonEncode(quizAnswers.toJson());
    await sharedPreferences?.setString('${quizAnswers.docId}', jsonString);
    return true;
  }

  static QuizAnswers? getQuizAnswers(String docId){
    String? jsonString = sharedPreferences?.getString(docId);
    if (jsonString != null) {
      dynamic json = jsonDecode(jsonString);
      return QuizAnswers.fromJson(json);
    } else {
      return null;
    }
  }

  static Future<bool> saveEvents(List<EventsModel?> events,String key) async {
    String jsonString = jsonEncode(
        events.map((eventsModel) => eventsModel?.toJson()).toList());
    await sharedPreferences?.setString(key, jsonString);
    return true;
  }

  static List<EventsModel> getEvents(String key) {
    String? jsonString = sharedPreferences?.getString(key);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      var index = -1;
      final events = jsonList
          .map((json) => EventsModel.fromJson(json, json['docId'] ?? "",key,index++))
          .toList();
      events.sort((a, b) => (b.dateTime ?? DateTime.now()).compareTo(a.dateTime ?? DateTime.now()));
      return events;
    } else {
      return [];
    }
  }

  static Future<bool> removeEvents(String key) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> removeClassData() async {
    return await sharedPreferences!.remove('class');
  }

  static Future<bool> removeQuizzes() async {
    return await sharedPreferences!.remove('quizzes');
  }

  static Future<bool>  removeData({
    @required String? key,
  })async
  {
    return await sharedPreferences!.remove(key!);
  }
}