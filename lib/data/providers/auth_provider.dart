import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/user.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/services/auth/auth_exceptions.dart';
import 'package:khata/services/auth/i_auth_provider.dart';

import 'user_provider.dart';

class AuthProvider implements IAuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserProvider _firebaseUserProvider;
  AuthProvider(this._firebaseUserProvider);

  @override
  Future<UserModel?> getUser({String? token}) async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return _firebaseUserProvider.read(firebaseUser.uid);
    }
    return null;
  }

  @override
  Future<UserModel?> signup({
    required String email,
    required String password,
    required Map<String, dynamic> body,
  }) async {
    return null;
  }

  @override
  Future<UserModel?> phoneAuth({required String phone}) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (String verificationId, int? resendToken) async {
        final result = await Get.toNamed(RouteNames.otpVerificationView);
        final String? smsCode = result as String?;

        // Create a PhoneAuthCredential with the code
        if (smsCode != null) {
          final phoneCred = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          final cred = await _firebaseAuth.signInWithCredential(phoneCred);
          if (cred.user != null) {
            final _user = UserModel(
              id: cred.user!.uid,
              phoneNumber: phone,
            );
            _firebaseUserProvider.create(_user);
            Get.offAllNamed(RouteNames.homeView);
          }
        } else {
          throw InvalidOTPCode(code: "otp");
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneCred) async {
        final cred = await _firebaseAuth.signInWithCredential(phoneCred);
        if (cred.user != null) {
          final _user = UserModel(
            id: cred.user!.uid,
            phoneNumber: phone,
          );
          _firebaseUserProvider.create(_user);
          Get.offAllNamed(RouteNames.homeView);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          throw InvalidPhoneException(code: e.code);
        }
      },
    );
    return null;
  }

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    return null;
  }

  @override
  Future<bool> updateUser(String uid, Map<String, Object?> data) async {
    return _firebaseUserProvider.update(uid, data);
  }

  @override
  Future<void> updateEmail(String newEmail, String password) async {}

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {}

  @override
  Future<void> forgotPassword(String email) async {}

  @override
  Future<bool> verifyEmail() async {
    return false;
  }

  @override
  Future<bool> uploadProfileImage(
    int userId,
    File profileImage,
    String? oldImage,
  ) async {
    return false;
  }

  @override
  Future<UserModel?> externalSignIn(authCred) async {
    return null;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
