import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khata/data/models/user.dart';

abstract class IAuthProvider {
  Future<UserModel?> getUser({String? token});

  Future<UserModel?> signup({
    required String email,
    required String password,
    required Map<String, dynamic> body,
  });

  Future<UserModel?> signInWithPhoneCred({
    required String phone,
    required PhoneAuthCredential phoneCred,
  });

  Future<void> phoneAuth({
    required String phone,
    required void Function(String?) onAutoVerify,
    required Future<void> Function(PhoneAuthCredential) onSuccess,
    required void Function() onError,
  });

  Future<UserModel?> login({required String email, required String password});

  Future<bool> updateUser(String uid, Map<String, Object?> data);

  Future<void> updateEmail(String newEmail, String password);

  Future<bool> verifyEmail();

  Future<void> changePassword(String oldPassword, String newPassword);

  Future<void> forgotPassword(String email);

  Future<bool> uploadProfileImage(
      int userId, File profileImage, String? oldImage);

  Future<UserModel?> externalSignIn(authCred);

  Future<void> signOut();
}
