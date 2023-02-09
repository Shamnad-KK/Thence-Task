// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fcm_bloc.dart';

abstract class FcmEvent extends Equatable {}

class InitLocalNotificationsEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class GetInitialMessageEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class SendForegroundNotificationsEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class BackgroundNotificationTappedEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class OnDidNotificationResponseEvent extends FcmEvent {
  final int id;
  OnDidNotificationResponseEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class GetFCMTokenEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class StoreFCMTokenEvent extends FcmEvent {
  final String deviceToken;
  StoreFCMTokenEvent({
    required this.deviceToken,
  });
  @override
  List<Object?> get props => [deviceToken];
}
