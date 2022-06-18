import 'package:get/get.dart';
import 'package:khata/modules/auth/auth_controller.dart';

abstract class IBaseController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  final user = Get.find<AuthController>().user!;
}
