// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitialized extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final String errorMessage;
  final String timeStamp;
  AuthErrorState({
    required this.errorMessage,
    required this.timeStamp,
  });
  @override
  List<Object?> get props => [
        errorMessage,
        timeStamp,
      ];
}
