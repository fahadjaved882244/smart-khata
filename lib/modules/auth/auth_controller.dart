import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/user.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/services/auth/auth_service.dart';
import 'package:khata/services/auth/i_auth_provider.dart';

class AuthController extends GetxService with AuthService {
  final IAuthProvider _authProvider;
  AuthController(this._authProvider);

  final Rxn<UserModel?> _userModel = Rxn();
  UserModel? get user => _userModel.value;

  Future<UserModel?> getUser() async {
    final user = await _authProvider.getUser();
    _userModel.value = user;
    return user;
  }

  Future<UserModel?> signInWithPhoneCred({
    required String phone,
    required PhoneAuthCredential phoneCred,
  }) async {
    final newUser = await _authProvider
        .signInWithPhoneCred(
          phone: phone,
          phoneCred: phoneCred,
        )
        .catchError(handleError);
    _userModel.value = newUser;
    return newUser;
  }

  Future<void> phoneAuthentication({
    required String phone,
    required void Function(String?) onAutoVerify,
    required Future<void> Function(PhoneAuthCredential) onSuccess,
    required void Function() onError,
  }) async {
    await _authProvider
        .phoneAuth(
            phone: phone,
            onAutoVerify: onAutoVerify,
            onSuccess: onSuccess,
            onError: onError)
        .catchError(handleError);
  }

  Future<bool> updateUser({
    required String name,
    required String phoneNumber,
  }) async {
    final status = await _authProvider
        .updateUser(user!.id, {"name": name, "phoneNumber": phoneNumber});
    if (status) {
      _userModel.value =
          _userModel.value!.copyWith(name: name, phoneNumber: phoneNumber);
    }
    return status;
  }

  Future<void> logout() async {
    await _authProvider.signOut();
    _userModel.value = null;
    Get.offAllNamed(RouteNames.phoneAuthView);
  }
}
