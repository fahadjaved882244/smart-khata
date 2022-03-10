import 'package:get/get.dart';
import 'package:khata/modules/auth/auth_controller.dart';

class HomeController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> logout() async {
    _isLoading(true);
    Get.find<AuthController>().logout();
    _isLoading(false);
  }
}
