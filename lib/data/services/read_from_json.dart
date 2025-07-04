import 'dart:convert';

import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:flutter/services.dart';

class ReadFromJson {
  Future<List<UserModel>> getMembersJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/users/users.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => UserModel.fromJson(json,json['uid'])).toList();
  }
}