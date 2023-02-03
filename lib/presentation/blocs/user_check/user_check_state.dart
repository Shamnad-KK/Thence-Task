part of 'user_check_bloc.dart';

enum UserStatus {
  none,
  loaded,
  loading,
}

class UserCheckState extends Equatable {
  final bool? userExists;
  final UserStatus? status;
  const UserCheckState({
    this.userExists,
    this.status,
  });

  UserCheckState copyWith({
    bool? userExists,
    UserStatus? status,
  }) {
    return UserCheckState(
      userExists: userExists ?? this.userExists,
      status: status ?? this.status,
    );
  }

  factory UserCheckState.initial() {
    return const UserCheckState(
      userExists: false,
      status: UserStatus.none,
    );
  }

  @override
  List<Object?> get props => [userExists, status];
}
