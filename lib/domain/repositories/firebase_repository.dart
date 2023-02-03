import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class FirebaseRepository {
  Future<bool> initLocalNotifications({
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
  });
  Future<void> sendForegroundMessage();
}
