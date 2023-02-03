import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thence_task/data/repositories/auth_repository_impl.dart';

part 'user_check_event.dart';
part 'user_check_state.dart';

class UserCheckBloc extends Bloc<UserCheckEvent, UserCheckState> {
  final AuthRepositoryImpl authRepository;
  UserCheckBloc({
    required this.authRepository,
  }) : super(UserCheckState.initial()) {
    on<CheckUserExistEvent>(_checkUserExists);
  }

  //This method will give true if there is already a user registered with this
  //mobile number..so that there is no need to save his username to firestore.
  void _checkUserExists(
    CheckUserExistEvent event,
    Emitter<UserCheckState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    final bool userExists = await authRepository.userExists(
      phone: event.phone,
    );
    log('user already exist : ${userExists.toString()}');

    emit(
      state.copyWith(
        userExists: userExists,
        status: UserStatus.loaded,
      ),
    );

    log(state.status.toString());
  }
}
