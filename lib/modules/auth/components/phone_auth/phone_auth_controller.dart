import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khata/modules/auth/auth_controller.dart';

class PhoneAuthController extends GetxController {
  late final TextEditingController phoneController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  void updateValidationMode() {
    autoValidate = AutovalidateMode.onUserInteraction;
    update(['UPDATE_FORM']);
  }

  Future<void> onSendCodePressed() async {
    isLoading = true;
    await Get.find<AuthController>().phoneAuthentication(
      phone: '+92${phoneController.text}',
      otp: "12312",
    );
    isLoading = false;
  }
}
