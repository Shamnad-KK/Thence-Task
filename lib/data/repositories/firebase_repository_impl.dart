import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:thence_task/domain/repositories/firebase_repository.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'high_importance_channel',
  description: 'This channel is used for imp notifications',
  importance: Importance.high,
  playSound: true,
);

class FirebaseRepositoryImpl extends FirebaseRepository {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseRepositoryImpl({
    required this.flutterLocalNotificationsPlugin,
  });

  @override
  Future<bool> initLocalNotifications({
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
  }) async {
    bool notificationTaped = false;
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      );
      return notificationTaped;
    } catch (e) {
      log(e.toString());
    }
    return notificationTaped;
  }

  @override
  Future<void> sendForegroundMessage() async {
    try {
      FirebaseMessaging.onMessage.listen((event) async {
        log('foreground message ${event.notification!.body}');
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android!;
        if (notification != null && android != null) {
          await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            event.notification?.title,
            event.notification?.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                playSound: true,
                importance: Importance.high,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
          log('message arrived');
          log(event.notification!.body!);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
