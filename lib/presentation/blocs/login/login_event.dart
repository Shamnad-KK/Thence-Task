part of 'login_bloc.dart';

abstract class LoginEvents extends Equatable {}

class LoginEvent extends LoginEvents {
  final String mobile;
  LoginEvent({
    required this.mobile,
  });
  @override
  List<Object?> get props => [mobile];
}

class CodeSentEvent extends LoginEvents {
  final String verId;
  CodeSentEvent({
    required this.verId,
  });
  @override
  List<Object?> get props => [verId];
}

class VerificationCompletedEvent extends LoginEvents {
  final PhoneAuthCredential credential;
  VerificationCompletedEvent({
    required this.credential,
  });
  @override
  List<Object?> get props => [credential];
}

class GetCodeEvent extends LoginEvents {
  final String otp;
  GetCodeEvent({
    required this.otp,
  });
  @override
  List<Object?> get props => [otp];
}

class VerifyOtpEvent extends LoginEvents {
  @override
  List<Object?> get props => [];
}

class SaveUserDetailsEvent extends LoginEvents {
  final String username;
  SaveUserDetailsEvent({
    required this.username,
  });
  @override
  List<Object?> get props => [username];
}

class ChangeRemainingTimeEvent extends LoginEvents {
  @override
  List<Object?> get props => [];
}

class ReduceRemainingTimeEvent extends LoginEvents {
  @override
  List<Object?> get props => [];
}

class SetRemainingTimeEvent extends LoginEvents {
  final int remainingTime;
  SetRemainingTimeEvent({
    required this.remainingTime,
  });
  @override
  List<Object?> get props => [remainingTime];
}
