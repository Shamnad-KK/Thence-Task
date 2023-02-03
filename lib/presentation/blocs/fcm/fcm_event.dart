// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class OnDidNotificationResponseEvent extends FcmEvent {
  @override
  List<Object?> get props => [];
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
