import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/repositories/auth_repository_impl.dart';
import 'package:thence_task/presentation/blocs/auth/auth_bloc.dart';
import 'package:thence_task/presentation/blocs/fcm/fcm_bloc.dart';
import 'package:thence_task/presentation/blocs/user_check/user_check_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final FirebaseAuth auth;
  final AuthRepositoryImpl authRepository;
  final FirebaseFirestore firestore;
  final AuthBloc authBloc;
  final UserCheckBloc userCheckBloc;
  final FcmBloc fcmBloc;
  LoginBloc({
    required this.auth,
    required this.authRepository,
    required this.firestore,
    required this.authBloc,
    required this.userCheckBloc,
    required this.fcmBloc,
  }) : super(LoginState.initial()) {
    on<LoginEvent>(_login);

    on<CodeSentEvent>(_codeSent);

    on<GetCodeEvent>(_getCode);

    on<VerificationCompletedEvent>(_verificationCompleted);

    on<VerifyOtpEvent>(_verifyOtp);

    on<SaveUserDetailsEvent>(_saveUserName);

    on<ChangeRemainingTimeEvent>(_changeRemainingTime);

    on<ReduceRemainingTimeEvent>(_reduceRemainingTime);

    on<SetRemainingTimeEvent>(_setRemainingTime);
  }

  void _setRemainingTime(
    SetRemainingTimeEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(timeRemaining: event.remainingTime),
    );
  }

  //This method is used for loggin in.
  void _login(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    await authRepository.login(
        phone: event.mobile,
        otp: state.otp!,
        codeSent: (verificationId, forceResendingToken) {
          add(CodeSentEvent(verId: verificationId));
          add(SetRemainingTimeEvent(remainingTime: 60));
        },
        verificationCompleted: (PhoneAuthCredential credential) {
          add(VerificationCompletedEvent(credential: credential));
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
          authBloc.add(SetUnAuthenticatedEvent());
        });
    emit(state.copyWith(phone: event.mobile));
  }

  //Saving the verification Id to state when firebase sends the otp
  void _codeSent(
    CodeSentEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(verId: event.verId));
  }

  void _verificationCompleted(
    VerificationCompletedEvent event,
    Emitter<LoginState> emit,
  ) async {
    log('verification completed');
    await auth.signInWithCredential(event.credential);
  }

  //This method will verify the otp which user entered
  void _verifyOtp(
    VerifyOtpEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await authRepository
          .verifyOtp(
        verId: state.verId!,
        smsCode: state.otp!,
      )
          .then((value) {
        //Checking if there is already a user registered with this phone
        userCheckBloc.add(CheckUserExistEvent(phone: state.phone!));

        ///Seting the auth state to [Authenticated]
        authBloc.add(SetAuthenticatedEvent());

        //Getting the current device token and storing it to firebase
        fcmBloc.add(GetFCMTokenEvent());

        ///Saving the authenticated status to sharedPreference so if the app
        /// is restarted..then user will redirected to [Homepage]
        authBloc.add(SaveAuthenticatedEvent());
      });
    } on FirebaseAuthException catch (e) {
      ///Seting the auth state to [AuthErrorState]
      addError(Exception(e.code.toString()), StackTrace.current);
      authBloc.add(SetAuthErrorEvent(errorMessage: e.code));
      log('incorrect otp');
      log(e.code.toString());
    } catch (e) {
      addError(Exception(e.toString()), StackTrace.current);
      authBloc.add(SetAuthErrorEvent(errorMessage: e.toString()));
    }
  }

  //This method will take userdata from the event and save to firebase
  void _saveUserName(
    SaveUserDetailsEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );
    await authRepository
        .saveUserInfo(
      userName: event.username,
    )
        .then((value) {
      emit(
        state.copyWith(status: LoginStatus.loaded),
      );
    });
  }

  void _changeRemainingTime(
    ChangeRemainingTimeEvent event,
    Emitter<LoginState> emit,
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

  //This method will reduce the otp remaining time
  void _reduceRemainingTime(
    ReduceRemainingTimeEvent event,
    Emitter<LoginState> emit,
  ) {
    int timeRemaining = state.timeRemaining!.toInt();
    timeRemaining = timeRemaining - 1;
    // log("remaining time : ${timeRemaining.toString()}");
    emit(
      state.copyWith(timeRemaining: timeRemaining),
    );
  }

  //This method will save the user entered otp to the state
  void _getCode(
    GetCodeEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(otp: event.otp),
    );
  }
}
