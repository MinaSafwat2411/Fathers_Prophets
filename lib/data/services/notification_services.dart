import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'cache/cache_helper.dart';

class NotificationService {
  final CacheHelper cacheHelper;
  NotificationService(this.cacheHelper);
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static bool _isPermissionRequested = false;

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(settings);

    await _safeRequestFirebaseMessaging(); // Move here instead of calling separately
  }

  static Future<void> _safeRequestFirebaseMessaging() async {
    if (_isPermissionRequested) return;
    _isPermissionRequested = true;

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      await messaging.requestPermission();
    } catch (e) {
      debugPrint("❌ Error requesting permission: $e");
    }

    try {
      String? token = await messaging.getToken();
      // await cacheHelper.saveData(key: 'fcmToken', value: token);
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

  static Future<void> showLocalNotification({required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails('channel_id', 'channel_name',
        importance: Importance.max, priority: Priority.high);
    const notificationDetails = NotificationDetails(android: androidDetails);
    await _localNotifications.show(0, title, body, notificationDetails);
  }
}

