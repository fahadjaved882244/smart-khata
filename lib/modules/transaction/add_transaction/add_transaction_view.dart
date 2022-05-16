import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/modules/transaction/add_transaction/add_transaction_controller.dart';
import 'package:khata/services/basic/text_validator.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

class AddTransactionView extends GetView<AddTransactionController> {
  final customer = Get.arguments[0] as CustomerModel;
  final willAdd = Get.arguments[1] as bool;

  AddTransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = willAdd ? AppColors.green : AppColors.red;
    return Obx(() {
      if (!controller.isLoading) {
        return BaseScaffold(
          title: "New Transaction",
          child: GetBuilder<AddTransactionController>(
            id: 'UPDATE_FORM',
            builder: (cntrl) {
              return Form(
                key: cntrl.formKey,
                autovalidateMode: cntrl.autoValidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomTextFormField(
                          autofocus: true,
                          controller: controller.amountController,
                          hintText: "Enter Amount*",
                          validator: TextValidator.priceValidator,
                          keyboardType: TextInputType.number,
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rs. ",
                                style: TextStyle(
                                  color: color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.smallPadding),
                        CustomTextFormField(
                          readOnly: true,
                          controller: controller.dateController,
                          prefixIcon: const Icon(Icons.calendar_month_outlined),
                          suffixIcon: const Icon(Icons.edit_outlined),
                          onTap: () => controller.updateDate(context),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: CustomTextFormField(
                            controller: controller.noteController,
                            hintText: "Write note here(optional)",
                            prefixIcon: const Icon(Icons.note_outlined),
                            keyboardType: TextInputType.text,
                            maxLines: null,
                          ),
                        ),
                        const SizedBox(width: AppSizes.exSmallPadding),
                        FloatingActionButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              await controller.addTransaction(
                                  customer, willAdd);
                            } else {
                              controller.updateValidationMode();
                            }
                          },
                          child: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return const CustomLoader();
      }
    });
  }
}
