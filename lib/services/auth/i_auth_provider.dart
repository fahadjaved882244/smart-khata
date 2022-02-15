import 'dart:io';
import 'package:khata/data/models/user.dart';

abstract class IAuthProvider {
  Future<UserModel?> getUser({String? token});

  Future<UserModel?> signup({
    required String email,
    required String password,
    required Map<String, dynamic> body,
  });

  Future<UserModel?> phoneAuth({required String phone, required String otp});

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
