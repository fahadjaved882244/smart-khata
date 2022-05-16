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

  Future<UserModel?> phoneAuthentication({required String phone}) async {
    final user =
        await _authProvider.phoneAuth(phone: phone).catchError(handleError);
    _userModel.value = user;
    return user;
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
