import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';

class FirebaseNotificationService {
  static final _scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  static late final ServiceAccountCredentials _credentials;

  static Future<void> init() async {
    final jsonStr = await rootBundle.loadString('assets/json/fathers-prophets-20a98-firebase-adminsdk-fbsvc-687811653a.json');
    _credentials = ServiceAccountCredentials.fromJson(jsonStr);
  }

  static Future<void> sendToToken({
    required String fcmToken,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    final client = await clientViaServiceAccount(_credentials, _scopes);
    final url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/fathers-prophets-20a98/messages:send',
    );

    final message = {
      "message": {
        "token": fcmToken,
        "notification": {
          "title": title,
          "body": body,
        },
        if (data != null) "data": data,
      }
    };

    await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(message),
    );
  }
}
