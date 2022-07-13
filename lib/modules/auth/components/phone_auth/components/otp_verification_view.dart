import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_controller.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/app_logo_text.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerificationView extends GetView<PhoneAuthController> {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleWidget: const AppLogoText(),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Text(
            "Phone Verification",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "Enter the OTP code send to ",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                "+92${controller.phoneController.text}.",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.mediumPadding),
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 55,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: const TextStyle(fontSize: 17),
            onCompleted: (pin) => onVerify(pin),
          ),
          const SizedBox(
            height: AppSizes.mediumPadding + AppSizes.smallPadding,
          ),
          CustomFilledButton(
            text: "Verifiy",
            onPressed: () => onVerify(""),
          ),
          const SizedBox(height: AppSizes.largePadding),
          Text(
            "Didn't received any code? ",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          TextButton(onPressed: () {}, child: const Text("Resend Code")),
        ],
      ),
    );
  }

  void onVerify(String code) {
    if (code.length == 6) {
      Get.back<String?>(result: code);
    } else {
      showCustomSnackBar(
        message: "Enter complete OTP code!",
        isError: true,
      );
    }
  }
}
