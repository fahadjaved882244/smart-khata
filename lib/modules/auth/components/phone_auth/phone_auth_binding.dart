import 'package:get/get.dart';

import 'phone_auth_controller.dart';

class PhoneAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneAuthController());
  }
}
