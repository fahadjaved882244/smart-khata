import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/customer/customer_list/customer_list_controller.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

class BalanceWidget extends GetView<CustomerListController> {
  final String businessId;
  const BalanceWidget(this.businessId, {Key? key}) : super(key: key);

  @override
  String? get tag => businessId;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final got = controller.dataList.fold<double>(0.0, ((prev, cus) {
        if (!cus.credit.isNegative) return prev + cus.credit;
        return prev;
      }));
      final gave = controller.dataList.fold<double>(0.0, ((prev, cus) {
        if (cus.credit.isNegative) return prev + cus.credit.abs();
        return prev;
      }));
      return Card(
        elevation: 0,
        shape: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.outline,
            )),
        child: SizedBox(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.smallPadding,
              right: AppSizes.smallPadding,
              bottom: AppSizes.smallPadding,
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      _creditCard(
                        context,
                        got,
                        "You Got",
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: AppSizes.exSmallPadding),
                      _creditCard(
                        context,
                        gave,
                        "You Gave",
                        Theme.of(context).colorScheme.errorContainer,
                        Theme.of(context).colorScheme.error,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.exSmallPadding),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _totalCard(context, got - gave),
                      const SizedBox(width: AppSizes.exSmallPadding),
                      _reportButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Flexible _reportButton(BuildContext context) {
    return Flexible(
      child: CustomFilledButton(
        elevation: 2,
        borderRadius: AppSizes.cardRadius,
        text: 'Report',
        icon: const Icon(
          Icons.picture_as_pdf_rounded,
          color: AppColors.red,
        ),
        onPressed: () {},
      ),
    );
  }

  Flexible _totalCard(BuildContext context, double amount) {
    return Flexible(
      flex: 2,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Balance"),
              Text(
                "Rs. ${amount.toInt()}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: amount == 0
                          ? AppColors.darkGray
                          : amount.isNegative
                              ? AppColors.red
                              : AppColors.green,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible _creditCard(BuildContext context, double amount, String type,
      Color bgcolor, Color fgColor) {
    return Flexible(
      child: Card(
        color: bgcolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Rs. ${amount.toInt()}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: fgColor),
              textAlign: TextAlign.center,
            ),
            Text(
              type,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: fgColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
