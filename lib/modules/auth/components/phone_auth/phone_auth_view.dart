import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_controller.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/app_logo_text.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/services/auth/auth_validator.dart';
import 'package:khata/themes/app_sizes.dart';

class PhoneAuthView extends GetView<PhoneAuthController> {
  const PhoneAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isLoading) {
        return BaseScaffold(
          titleWidget: const AppLogoText(),
          child: ListView(
            children: [
              Text(
                "Phone Authentication",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                "We will send you an SMS with a OTP to your phone number.",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: AppSizes.mediumPadding),
              GetBuilder<PhoneAuthController>(
                  id: 'UPDATE_FORM',
                  builder: (cntrl) {
                    return Form(
                      key: cntrl.formKey,
                      autovalidateMode: cntrl.autoValidate,
                      child: CustomTextFormField(
                        controller: cntrl.phoneController,
                        hintText: "3XX XXXXXXX",
                        keyboardType: TextInputType.phone,
                        validator: AuthValidator.phoneValidator,
                        onChanged: (value) {
                          if (value.length == 1 && value[0] == '0') {
                            cntrl.phoneController.clear();
                          }
                        },
                        prefixIcon: _countryCode(),
                        suffixIcon: IconButton(
                          onPressed: () => cntrl.phoneController.clear(),
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: AppSizes.mediumPadding + AppSizes.smallPadding,
              ),
              CustomFilledButton(
                text: "Send OTP Code",
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    await controller.onSendCodePressed();
                  } else {
                    controller.updateValidationMode();
                  }
                },
              ),
            ],
          ),
        );
      } else {
        return const CustomLoader();
      }
    });
  }

  Padding _countryCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "🇵🇰",
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 4),
          Text(
            "+92",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
