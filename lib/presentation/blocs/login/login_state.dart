// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

enum LoginStatus {
  loading,
  loaded,
  error,
}

class LoginState extends Equatable {
  final LoginStatus? status;
  final String? verId;
  final String? otp;
  final int? timeRemaining;
  final bool? userExists;
  final String? phone;
  final String? userName;
  final String? errorMessage;

  const LoginState({
    this.status,
    this.verId,
    this.otp,
    this.timeRemaining,
    this.userExists,
    this.phone,
    this.userName,
    this.errorMessage,
  });

  factory LoginState.initial() {
    return const LoginState(
      verId: '',
      otp: '',
      status: LoginStatus.loading,
      timeRemaining: 60,
      userExists: false,
      phone: '',
      userName: '',
      errorMessage: '',
    );
  }

  LoginState copyWith({
    LoginStatus? status,
    String? verId,
    String? otp,
    int? timeRemaining,
    bool? userExists,
    String? phone,
    String? userName,
    //bool? verificationSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      verId: verId ?? this.verId,
      otp: otp ?? this.otp,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      userExists: userExists ?? this.userExists,
      phone: phone ?? this.phone,
      userName: userName ?? this.userName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        verId,
        otp,
        status,
        timeRemaining,
        userExists,
        phone,
        userName,
        errorMessage,
      ];
}
