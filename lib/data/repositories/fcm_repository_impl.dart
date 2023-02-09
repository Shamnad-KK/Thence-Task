import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:thence_task/domain/repositories/fcm_repository.dart';

class FcmRepositoryImpl extends FcmRepository {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;
  FcmRepositoryImpl({
    required this.flutterLocalNotificationsPlugin,
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  AndroidNotificationChannel kAndroidNotificationChannel =
      const AndroidNotificationChannel(
    'high_importance_channel',
    'high_importance_channel',
    description: 'This channel is used for imp notifications',
    importance: Importance.max,
    playSound: true,
  );

  @override
  Future<void> initLocalNotifications({
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
  }) async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(kAndroidNotificationChannel);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,

        ///This will be called when the user taps on a notification when the app
        ///is in only on the foreground state
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  ///This will be called when the user taps on a notification when the app
  ///is in terminated state
  @override
  Future<RemoteMessage?> getInitialMessage() async {
    try {
      FirebaseMessaging.instance.getInitialMessage().then((value) {
        if (value == null) {
          return null;
        }
        return value;
      });
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  ///This will be called when the notification recieves and
  ///is in only on the foreground state
  @override
  Future<void> sendForegroundMessage() async {
    try {
      FirebaseMessaging.onMessage.listen(
        (message) async {
          log('foreground message ${message.notification!.body}');
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android!;
          if (notification != null && android != null) {
            await flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  kAndroidNotificationChannel.id,
                  kAndroidNotificationChannel.name,
                  channelDescription: kAndroidNotificationChannel.description,
                  playSound: true,
                  importance: Importance.high,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
              payload: message.data["type"] == 'product_navigation'
                  ? message.data["productId"]
                  : null,
            );
            log('message arrived');
            log(notification.body!);
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  ///This will be called when the user taps on a notification when the app
  ///is in background state
  @override
  Future<void> onBackgroundMessageTapped(
      {void Function(RemoteMessage)? onData}) async {
    try {
      FirebaseMessaging.onMessageOpenedApp.listen(
        onData,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<String?> getFCMtoken() async {
    try {
      final String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<void> storeFCMtokenToFirebase(String deviceToken) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.phoneNumber)
          .update({
        "device_token": deviceToken,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
