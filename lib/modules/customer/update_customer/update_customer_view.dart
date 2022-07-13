import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/modules/customer/update_customer/update_customer_controller.dart';
import 'package:khata/services/basic/text_validator.dart';
import 'package:khata/themes/app_sizes.dart';

class UpdateCustomerView extends StatelessWidget {
  final businessId = Get.parameters['businessId'] as String;
  final CustomerModel customer = Get.arguments as CustomerModel;
  UpdateCustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateCustomerController(businessId, customer));

    return Obx(
      () {
        if (!controller.isLoading) {
          return BaseScaffold(
            title: "Update Customer",
            child: GetBuilder<UpdateCustomerController>(
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
                          suffixIcon: const Icon(Icons.edit_outlined),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        const SizedBox(height: AppSizes.smallPadding),
                        CustomTextFormField(
                          controller: controller.phoneController,
                          hintText: "Phone Number",
                          validator: TextValidator.phoneValidator,
                          suffixIcon: const Icon(Icons.edit_outlined),
                          prefixIcon: const Icon(Icons.phone_android),
                        ),
                        const SizedBox(height: AppSizes.largePadding),
                        CustomFilledButton(
                          text: "Update Customer",
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.updateCustomer();
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
