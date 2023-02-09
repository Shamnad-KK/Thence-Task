part of 'fcm_bloc.dart';

class FcmState extends Equatable {
  final bool? notificationTaped;
  final RemoteMessage? message;
  const FcmState({
    this.notificationTaped,
    this.message,
  });

  factory FcmState.initial() {
    return const FcmState(
      notificationTaped: false,
      message: null,
    );
  }

  FcmState copyWith({
    bool? notificationTaped,
    RemoteMessage? message,
  }) {
    return FcmState(
      notificationTaped: notificationTaped ?? this.notificationTaped,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [notificationTaped, message];
}
