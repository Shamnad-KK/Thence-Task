import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> login({
    required String phone,
    required String otp,
    required Function(
      String verificationId,
      int? forceResendingToken,
    )
        codeSent,
    required void Function(PhoneAuthCredential) verificationCompleted,
  });
  Future<void> verifyOtp({
    required String verId,
    required String smsCode,
  });
  Future<void> saveUserInfo({
    required String userName,
  });

  Future<bool> userExists({required String phone});

  Future<void> saveAuthResponse();

  Future<bool> getAuthResponse();

  Future<void> signOut();
}
