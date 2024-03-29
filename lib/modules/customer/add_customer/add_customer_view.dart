import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/contact.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/services/basic/text_validator.dart';
import 'package:khata/themes/app_sizes.dart';

import 'add_customer_controller.dart';

class AddCustomerView extends StatelessWidget {
  final String businessId = Get.parameters["businessId"] as String;
  final ContactModel? contact = Get.arguments as ContactModel?;
  AddCustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddCustomerController(contact, businessId));

    return Obx(
      () {
        if (!controller.isLoading) {
          return BaseScaffold(
            title: "Add New Contact",
            child: GetBuilder<AddCustomerController>(
                id: 'UPDATE_FORM',
                builder: (cntrl) {
                  return Form(
                    key: cntrl.formKey,
                    autovalidateMode: cntrl.autoValidate,
                    child: ListView(
                      children: [
                        CustomTextFormField(
                          controller: controller.nameController,
                          hintText: "Name*",
                          validator: TextValidator.nameValidator,
                          prefixIcon: const Icon(Icons.person),
                        ),
                        const SizedBox(height: AppSizes.smallPadding),
                        CustomTextFormField(
                          controller: controller.phoneController,
                          hintText: "Phone Number",
                          validator: TextValidator.phoneValidator,
                          prefixIcon: const Icon(Icons.phone_android),
                        ),
                        const SizedBox(height: AppSizes.largePadding),
                        CustomFilledButton(
                          text: "Save Contact",
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              await controller.addCustomer();
                            } else {
                              controller.updateValidationMode();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }),
          );
        } else {
          return const CustomLoader();
        }
      },
    );
  }
}
