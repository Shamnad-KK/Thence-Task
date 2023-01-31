part of 'auth_bloc.dart';

enum AuthStatus {
  loading,
  loaded,
  error,
}

class AuthState extends Equatable {
  final AuthStatus? status;
  final String? verId;
  final String? otp;
  final int? timeRemaining;
  final bool? userExists;
  final String? phone;
  final String? userName;
  final bool? alreadyLoggedIn;
  const AuthState({
    this.status,
    this.verId,
    this.otp,
    this.timeRemaining,
    this.userExists,
    this.phone,
    this.userName,
    this.alreadyLoggedIn,
  });

  factory AuthState.initial() {
    return const AuthState(
      verId: '',
      otp: '',
      status: AuthStatus.loading,
      timeRemaining: 60,
      userExists: false,
      phone: '',
      userName: '',
      alreadyLoggedIn: false,
    );
  }

  AuthState copyWith({
    AuthStatus? status,
    String? verId,
    String? otp,
    int? timeRemaining,
    bool? userExists,
    String? phone,
    String? userName,
    bool? alreadyLoggedIn,
  }) {
    return AuthState(
      status: status ?? this.status,
      verId: verId ?? this.verId,
      otp: otp ?? this.otp,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      userExists: userExists ?? this.userExists,
      phone: phone ?? this.phone,
      userName: userName ?? this.userName,
      alreadyLoggedIn: alreadyLoggedIn ?? this.alreadyLoggedIn,
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
        alreadyLoggedIn,
      ];
}
