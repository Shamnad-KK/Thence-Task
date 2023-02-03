part of 'fcm_bloc.dart';

class FcmState extends Equatable {
  final bool? notificationTaped;
  const FcmState({
    this.notificationTaped,
  });
  @override
  List<Object?> get props => [notificationTaped];

  FcmState copyWith({
    bool? notificationTaped,
  }) {
    return FcmState(
      notificationTaped: notificationTaped ?? this.notificationTaped,
    );
  }

  factory FcmState.initial() {
    return const FcmState(
      notificationTaped: false,
    );
  }
}
