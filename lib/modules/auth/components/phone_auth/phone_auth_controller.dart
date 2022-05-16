import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khata/modules/auth/auth_controller.dart';
import 'package:khata/routes/route_names.dart';

class PhoneAuthController extends GetxController {
  late final TextEditingController phoneController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

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
    _isLoading(true);
    FocusManager.instance.primaryFocus?.unfocus();
    final cntrl = Get.find<AuthController>();
    final user = await cntrl.phoneAuthentication(
      phone: '+92${phoneController.text}',
    );
    _isLoading(false);
    if (user != null) {
      Get.offAllNamed(RouteNames.homeView);
    }
  }
}
