import 'package:get/get.dart';
import 'package:khata/data/models/user.dart';
import 'package:khata/services/auth/auth_service.dart';
import 'package:khata/services/auth/i_auth_provider.dart';

class AuthController extends GetxService with AuthService {
  final IAuthProvider _authProvider;
  AuthController(this._authProvider);

  final Rxn<UserModel?> _userModel = Rxn();
  UserModel? get user => _userModel.value;

  Future<UserModel?> getUser() async {
    final _user = await _authProvider.getUser();
    _userModel.value = _user;
    return _user;
  }

  Future<UserModel?> phoneAuthentication(
      {required String phone, required String otp}) async {
    final _user = await _authProvider
        .phoneAuth(phone: phone, otp: otp)
        .catchError(handleError);
    _userModel.value = _user;
    return _user;
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
    _userModel.value = null;
    await _authProvider.signOut();
  }
}
