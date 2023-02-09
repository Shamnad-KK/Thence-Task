import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/repositories/fcm_repository_impl.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';

part 'fcm_event.dart';
part 'fcm_state.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  final FcmRepositoryImpl fcmRepositoryImpl;
  final HomeBloc homeBloc;

  FcmBloc({
    required this.fcmRepositoryImpl,
    required this.homeBloc,
  }) : super(FcmState.initial()) {
    on<InitLocalNotificationsEvent>(_initLocalNotifications);

    on<GetInitialMessageEvent>(_getInitialMessage);

    on<SendForegroundNotificationsEvent>(_sendForegroundNotifications);

    on<BackgroundNotificationTappedEvent>(_backgroundNotificationTapped);

    on<OnDidNotificationResponseEvent>(_onDidReceiveNotificationResponse);

    on<GetFCMTokenEvent>(_getFCMtoken);

    on<StoreFCMTokenEvent>(_storeFcmToken);
  }

  void _initLocalNotifications(
    InitLocalNotificationsEvent event,
    Emitter<FcmState> emit,
  ) async {
    await fcmRepositoryImpl.initLocalNotifications(
      onDidReceiveNotificationResponse: (notification) {
        if (notification.payload != null) {
          final int id = int.parse(notification.payload!);
          log(notification.id.toString());
          add(OnDidNotificationResponseEvent(id: id));
        }
      },
    );
  }

  ///This will be called when the user taps on a notification when the app
  ///is in terminated state
  void _getInitialMessage(
    GetInitialMessageEvent event,
    Emitter<FcmState> emit,
  ) async {
    await fcmRepositoryImpl.getInitialMessage().then((message) {
      if (message != null) {
        if (message.data["type"] == 'product_navigation') {
          final int id = int.parse(message.data["productId"]);
          add(OnDidNotificationResponseEvent(id: id));
        }
      }
    });
  }

  ///This will be called when the notification recieves and
  ///is in only on the foreground state
  void _sendForegroundNotifications(
    SendForegroundNotificationsEvent event,
    Emitter<FcmState> emit,
  ) async {
    await fcmRepositoryImpl.sendForegroundMessage();
  }

  ///This will be called when the user taps on a notification when the app
  ///is in background state
  void _backgroundNotificationTapped(
    BackgroundNotificationTappedEvent event,
    Emitter<FcmState> emit,
  ) async {
    await fcmRepositoryImpl.onBackgroundMessageTapped(
      onData: (message) {
        if (message.data["type"] == 'product_navigation') {
          final int id = int.parse(message.data["productId"]);
          add(OnDidNotificationResponseEvent(id: id));
        }
      },
    );
  }

  ///This will be called when the user taps on a notification when the app
  ///is in only on the foreground state
  void _onDidReceiveNotificationResponse(
    OnDidNotificationResponseEvent event,
    Emitter<FcmState> emit,
  ) {
    if (homeBloc.state.products != null) {
      log('notification tapped');

      final product = homeBloc.state
          .products![event.id < homeBloc.state.products!.length ? event.id : 0];
      homeBloc.add(
        SelectAProductEvent(product: product),
      );
      emit(
        state.copyWith(notificationTaped: true),
      );
    }
  }

  void _getFCMtoken(
    GetFCMTokenEvent event,
    Emitter<FcmState> emit,
  ) async {
    await fcmRepositoryImpl.getFCMtoken().then((value) {
      if (value != null) {
        log("Device token : $value");
        add(StoreFCMTokenEvent(deviceToken: value));
      }
    });
  }

  void _storeFcmToken(
    StoreFCMTokenEvent event,
    Emitter<FcmState> emit,
  ) async {
    await fcmRepositoryImpl.storeFCMtokenToFirebase(
      event.deviceToken,
    );
  }
}
