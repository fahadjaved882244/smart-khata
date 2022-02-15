import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OtpVerificationController extends GetxController {
  late final OtpFieldController otpController;
  final Rx<String> code = "".obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  @override
  void onInit() {
    otpController = OtpFieldController();
    super.onInit();
  }

  @override
  void onClose() {
    otpController.clear();
    super.onClose();
  }

  void updateValidationMode() {
    autoValidate = AutovalidateMode.onUserInteraction;
    update(['UPDATE_FORM']);
  }
}
