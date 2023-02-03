import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/repositories/firebase_repository_impl.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';

part 'fcm_event.dart';
part 'fcm_state.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  final FirebaseRepositoryImpl firebaseRepositoryImpl;
  final HomeBloc homeBloc;

  FcmBloc({
    required this.firebaseRepositoryImpl,
    required this.homeBloc,
  }) : super(FcmState.initial()) {
    on<InitLocalNotificationsEvent>(_initLocalNotifications);

    on<SendForegroundNotificationsEvent>(_sendForegroundNotifications);

    on<OnDidNotificationResponseEvent>(_onDidReceiveNotificationResponse);

    on<GetFCMTokenEvent>(_getFCMtoken);

    on<StoreFCMTokenEvent>(_storeFcmToken);
  }

  void _initLocalNotifications(
    InitLocalNotificationsEvent event,
    Emitter<FcmState> emit,
  ) async {
    await firebaseRepositoryImpl.initLocalNotifications(
      onDidReceiveNotificationResponse: (p0) {
        log(p0.id.toString());
        add(OnDidNotificationResponseEvent());
      },
    );
  }

  void _sendForegroundNotifications(
    SendForegroundNotificationsEvent event,
    Emitter<FcmState> emit,
  ) async {
    await firebaseRepositoryImpl.sendForegroundMessage();
  }

  void _onDidReceiveNotificationResponse(
    OnDidNotificationResponseEvent event,
    Emitter<FcmState> emit,
  ) {
    if (homeBloc.state.products != null) {
      log('notification tapped');
      final product = homeBloc.state.products![0];
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
    await firebaseRepositoryImpl.getFCMtoken().then((value) {
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
    await firebaseRepositoryImpl.storeFCMtokenToFirebase(
      event.deviceToken,
    );
  }
}
