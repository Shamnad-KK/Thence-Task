// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class GetAuthStatusEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SetAuthenticatedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SetUnAuthenticatedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SetAuthErrorEvent extends AuthEvent {
  final String errorMessage;
  SetAuthErrorEvent({
    required this.errorMessage,
  });
  @override
  List<Object?> get props => [errorMessage];
}

class SaveAuthenticatedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
