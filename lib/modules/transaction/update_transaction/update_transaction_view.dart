import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/services/basic/text_validator.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

import 'update_transaction_controller.dart';

class UpdateTransactionView extends GetView<UpdateTransactionController> {
  final customerId = Get.arguments[0] as String;
  final transaction = Get.arguments[1] as TransactionModel;
  UpdateTransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateTransactionController(transaction));

    final color =
        !transaction.amount.isNegative ? AppColors.green : AppColors.red;
    return Obx(() {
      if (!controller.isLoading) {
        return BaseScaffold(
          title: "Update Transaction",
          child: GetBuilder<UpdateTransactionController>(
            id: 'UPDATE_FORM',
            builder: (cntrl) {
              return Form(
                key: cntrl.formKey,
                autovalidateMode: cntrl.autoValidate,
                child: ListView(
                  children: [
                    CustomTextFormField(
                      controller: controller.amountController,
                      hintText: "Enter Amount*",
                      validator: TextValidator.priceValidator,
                      keyboardType: TextInputType.number,
                      suffixIcon: const Icon(Icons.edit_outlined),
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
                      suffixIcon: const Icon(Icons.edit_outlined),
                      prefixIcon: const Icon(Icons.calendar_month_outlined),
                      onTap: () => controller.updateDate(context),
                    ),
                    const SizedBox(height: AppSizes.smallPadding),
                    CustomTextFormField(
                      controller: controller.noteController,
                      hintText: "Write note here(optional)",
                      suffixIcon: const Icon(Icons.edit_outlined),
                      prefixIcon: const Icon(Icons.note_outlined),
                      keyboardType: TextInputType.text,
                      maxLines: null,
                    ),
                    const SizedBox(height: AppSizes.mediumPadding),
                    CustomFilledButton(
                      text: "Update Transaction",
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.updateTransaction(customerId);
                        } else {
                          controller.updateValidationMode();
                        }
                      },
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
