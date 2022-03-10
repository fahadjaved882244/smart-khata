import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_controller.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

import 'components/bottom_button_bar.dart';

class CustomerDetailView extends GetView<CustomerDetailController> {
  final customer = Get.arguments as CustomerModel;
  CustomerDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasPhNum = customer.phoneNumber != null;
    return Obx(() {
      if (!controller.isLoading) {
        return BaseScaffold(
          title: customer.name,
          noPadding: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.phone_outlined),
            ),
            IconButton(
              onPressed: () async {
                await controller.deleteCustomer(customer.id);
              },
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ],
          bottomNavigationBar: BottomButtonBar(customer: customer),
          child: Column(children: [
            Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(),
              child: SizedBox(
                height: customer.credit == 0 ? 80 : 120,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppSizes.exSmallPadding,
                    right: AppSizes.exSmallPadding,
                    bottom: AppSizes.smallPadding,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (customer.credit != 0)
                          _totalCard(context, customer.credit),
                        const SizedBox(height: AppSizes.exSmallPadding),
                        _buttonBar(hasPhNum),
                      ]),
                ),
              ),
            ),
          ]),
        );
      } else {
        return const CustomLoader();
      }
    });
  }

  Flexible _buttonBar(bool hasPhNum) {
    return Flexible(
      flex: 4,
      child: Row(
        children: [
          Flexible(
            child: CustomFilledButton(
              elevation: 2,
              heightScale: 0,
              borderRadius: AppSizes.cardRadius,
              icon: const Icon(
                Icons.picture_as_pdf_rounded,
                color: AppColors.red,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: CustomFilledButton(
              elevation: 2,
              borderRadius: AppSizes.cardRadius,
              heightScale: 0,
              text: "WhatsApp",
              icon: Icon(
                Icons.whatsapp,
                color: hasPhNum ? AppColors.green : AppColors.darkGray,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: CustomFilledButton(
              elevation: 2,
              heightScale: 0,
              borderRadius: AppSizes.cardRadius,
              text: "SMS",
              icon: Icon(
                Icons.sms_rounded,
                color: hasPhNum ? AppColors.blue : AppColors.darkGray,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Flexible _totalCard(BuildContext context, double amount) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(amount.isNegative ? "You Will Get" : "You Will Give"),
              Text(
                "Rs. ${amount.toInt()}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: amount.isNegative ? AppColors.red : AppColors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
