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


  static Future<bool> saveClasses(List<ClassModel> classes) async {
    String jsonString = jsonEncode(
        classes.map((classModel) => classModel.toJson()).toList());
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
      final events = jsonList
          .map((json) => EventsModel.fromJson(json, json['docId'] ?? "",key))
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