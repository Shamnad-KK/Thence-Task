import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/repositories/auth_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(AuthInitialized()) {
    on<GetAuthStatusEvent>(_getAuthStatus);

    on<SaveAuthenticatedEvent>(_saveAuthenticated);

    on<SetAuthenticatedEvent>(_setAuthenticated);

    on<SetAuthErrorEvent>(_setAutherror);

    on<SetUnAuthenticatedEvent>(_setUnAuthenticated);

    on<SignOutEvent>(_signOut);
  }

  void _getAuthStatus(
    GetAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final authStatus = await authRepository.getAuthResponse();
    if (authStatus == true) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void _saveAuthenticated(
    SaveAuthenticatedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.saveAuthStatus().then((value) {
      emit(Authenticated());
    });
  }

  void _setAuthenticated(
    SetAuthenticatedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(Authenticated());
    // await authRepository.setAuthStatus();
  }

  void _setUnAuthenticated(
    SetUnAuthenticatedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(Unauthenticated());
  }

  void _setAutherror(
    SetAuthErrorEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      AuthErrorState(
        errorMessage: event.errorMessage,
        timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }

  void _signOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.signOut().then(
      (value) {
        add(SetUnAuthenticatedEvent());
      },
    );
  }
}
