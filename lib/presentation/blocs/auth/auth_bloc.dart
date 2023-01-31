// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thence_task/data/repositories/auth_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth auth;
  final AuthRepositoryImpl authRepository;
  final FirebaseFirestore firestore;
  AuthBloc({
    required this.auth,
    required this.authRepository,
    required this.firestore,
  }) : super(AuthState.initial()) {
    on<LoginEvent>(_login);

    on<CodeSentEvent>(_codeSent);

    on<GetCodeEvent>(_getCode);

    on<VerificationCompletedEvent>(_verificationCompleted);

    on<VerifyOtpEvent>(_verifyOtp);

    on<SaveUserDetailsEvent>(_saveUserName);

    on<ChangeRemainingTimeEvent>(_changeRemainingTime);

    on<ReduceRemainingTimeEvent>(_reduceRemainingTime);

    on<CheckUserExistEvent>(_checkUserExists);

    on<SetRemainingTimeEvent>(_setRemainingTime);

    on<SetAuthResponseEvent>(_setAuthResponse);

    on<GetAuthResponseEvent>(_getAuthResponse);

    on<SignOutEvent>(_signOut);
  }

  void _setRemainingTime(
    SetRemainingTimeEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(timeRemaining: event.remainingTime),
    );
  }

  void _changeRemainingTime(
    ChangeRemainingTimeEvent event,
    Emitter<AuthState> emit,
  ) {
    Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (state.timeRemaining != 0) {
          add(ReduceRemainingTimeEvent());
        }
      },
    );
  }

  void _reduceRemainingTime(
    ReduceRemainingTimeEvent event,
    Emitter<AuthState> emit,
  ) {
    int timeRemaining = state.timeRemaining!.toInt();
    timeRemaining = timeRemaining - 1;
    // log("remaining time : ${timeRemaining.toString()}");
    emit(
      state.copyWith(timeRemaining: timeRemaining),
    );
  }

  void _getCode(
    GetCodeEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(otp: event.otp),
    );
  }

  //This method is used for loggin in.
  void _login(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.login(
      phone: event.mobile,
      otp: state.otp!,
      codeSent: (verificationId, forceResendingToken) {
        add(CodeSentEvent(verId: verificationId));
      },
      verificationCompleted: (PhoneAuthCredential credential) {
        add(VerificationCompletedEvent(credential: credential));
      },
    );
    emit(state.copyWith(phone: event.mobile, timeRemaining: 30));
  }

  //Saving the verification Id to state when firebase sends the otp
  void _codeSent(
    CodeSentEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(verId: event.verId));
  }

  void _verificationCompleted(
    VerificationCompletedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await auth.signInWithCredential(event.credential);
  }

  //This method will verify the otp which user
  void _verifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authRepository
          .verifyOtp(
        verId: state.verId!,
        smsCode: state.otp!,
      )
          .whenComplete(() {
        add(SetRemainingTimeEvent(remainingTime: 0));
      });
    } catch (e) {
      log('kee');
    }
  }

  //This method will take userdata from the event and save to firebase
  void _saveUserName(
    SaveUserDetailsEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.saveUserInfo(
      userName: event.username,
    );
  }

  void _checkUserExists(
    CheckUserExistEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(status: AuthStatus.loading),
    );
    final bool userExists = await authRepository.userExists(
      phone: event.phone,
    );
    log('user already exist : ${userExists.toString()}');

    emit(
      state.copyWith(
        userExists: userExists,
        status: AuthStatus.loaded,
      ),
    );
  }

  //This method will store a true boolean in shared preference if user signs in.
  void _setAuthResponse(
    SetAuthResponseEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.saveAuthResponse();
  }

  //This method will get the stored auth boolean and emit to the state
  void _getAuthResponse(
    GetAuthResponseEvent event,
    Emitter<AuthState> emit,
  ) async {
    final alreadyLoggedIn = await authRepository.getAuthResponse();
    emit(
      state.copyWith(alreadyLoggedIn: alreadyLoggedIn),
    );
  }

  //This method will get the stored auth boolean and emit to the state
  void _signOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(status: AuthStatus.loading),
    );
    await authRepository.signOut();
    emit(
      state.copyWith(status: AuthStatus.loaded),
    );
  }
}
