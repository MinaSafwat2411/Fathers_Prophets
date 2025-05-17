import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(settings);
  }

  static Future<void> showLocalNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails('channel_id', 'channel_name',
        importance: Importance.max, priority: Priority.high);

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    await _localNotifications.show(0, title, body, details);
  }

  static Future<void> handleFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    // 🔁 Retry logic with delay
    await Future.delayed(Duration(seconds: 2));
    try {
      String? token = await messaging.getToken();
      debugPrint("✅ FCM Token: $token");
    } catch (e) {
      debugPrint("❌ Error getting FCM token: $e");
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(
          title: message.notification!.title ?? "New Notification",
          body: message.notification!.body ?? "No message body",
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("🔔 Notification clicked! Data: ${message.data}");
    });
  }

}
