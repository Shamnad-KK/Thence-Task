// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class LoginEvent extends AuthEvent {
  final String mobile;
  LoginEvent({
    required this.mobile,
  });
  @override
  List<Object?> get props => [mobile];
}

class CodeSentEvent extends AuthEvent {
  final String verId;
  CodeSentEvent({
    required this.verId,
  });
  @override
  List<Object?> get props => [verId];
}

class VerificationCompletedEvent extends AuthEvent {
  final PhoneAuthCredential credential;
  VerificationCompletedEvent({
    required this.credential,
  });
  @override
  List<Object?> get props => [credential];
}

class GetCodeEvent extends AuthEvent {
  final String otp;
  GetCodeEvent({
    required this.otp,
  });
  @override
  List<Object?> get props => [otp];
}

class VerifyOtpEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SaveUserDetailsEvent extends AuthEvent {
  final String username;
  SaveUserDetailsEvent({
    required this.username,
  });
  @override
  List<Object?> get props => [username];
}

class ChangeRemainingTimeEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ReduceRemainingTimeEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SetRemainingTimeEvent extends AuthEvent {
  final int remainingTime;
  SetRemainingTimeEvent({
    required this.remainingTime,
  });
  @override
  List<Object?> get props => [remainingTime];
}

class CheckUserExistEvent extends AuthEvent {
  final String phone;
  CheckUserExistEvent({
    required this.phone,
  });
  @override
  List<Object?> get props => [phone];
}

class SetAuthResponseEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class GetAuthResponseEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
