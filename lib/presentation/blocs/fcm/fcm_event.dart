part of 'fcm_bloc.dart';

abstract class FcmEvent extends Equatable {}

class InitLocalNotificationsEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class SendForegroundNotificationsEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class OnNotificationTapEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}

class OnDidNotificationResponseEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
}
