part of 'user_check_bloc.dart';

abstract class UserCheckEvent extends Equatable {}

class CheckUserExistEvent extends UserCheckEvent {
  final String phone;
  CheckUserExistEvent({
    required this.phone,
  });
  @override
  List<Object?> get props => [phone];
}
