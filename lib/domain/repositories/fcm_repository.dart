import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class FcmRepository {
  Future<void> initLocalNotifications({
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
  });
  Future<RemoteMessage?> getInitialMessage();
  Future<void> sendForegroundMessage();
  Future<void> onBackgroundMessageTapped(
      {void Function(RemoteMessage)? onData});
  Future<String?> getFCMtoken();
  Future<void> storeFCMtokenToFirebase(String deviceToken);
}
