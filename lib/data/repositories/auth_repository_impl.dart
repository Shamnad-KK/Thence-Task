import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thence_task/core/strings.dart';

import 'package:thence_task/data/model/user_model.dart';
import 'package:thence_task/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepositoryImpl({
    required this.auth,
    required this.firestore,
  });
  @override
  Future<void> login({
    required String phone,
    required String otp,
    required Function(
      String verificationId,
      int? forceResendingToken,
    )
        codeSent,
    required void Function(PhoneAuthCredential) verificationCompleted,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {
          log('time out');
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> verifyOtp(
      {required String verId, required String smsCode}) async {
    try {
      await auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verId,
          smsCode: smsCode,
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> saveUserInfo({required String userName}) async {
    try {
      final user = UserModel(
        id: auth.currentUser!.uid,
        userName: userName,
      );
      log('aaa : ${auth.currentUser!.phoneNumber}');
      await firestore
          .collection('users')
          .doc(
            auth.currentUser!.phoneNumber,
          )
          .set(user.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<bool> userExists({required String phone}) async {
    try {
      final userDoc = await firestore
          .collection('users')
          .doc(
            phone,
          )
          .get();
      if (userDoc.exists) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<void> saveAuthResponse() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool(AppStrings.authResponse, true);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<bool> getAuthResponse() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final authResponse = sharedPreferences.getBool(AppStrings.authResponse);
      return authResponse ?? false;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<void> signOut() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await auth.signOut().then((value) {
        sharedPreferences.remove(AppStrings.authResponse);
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
