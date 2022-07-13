import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/modules/customer/customer_list/customer_list_controller.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/extensions/date_time_extensions.dart';
import 'package:khata/themes/app_theme.dart';

class CustomerListWidget extends GetView<CustomerListController> {
  const CustomerListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        itemCount: controller.dataList.length,
        itemBuilder: (context, i) {
          final customer = controller.dataList[i];

          return Obx(() {
            return Row(
              children: [
                if (controller.isSelectable)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.exSmallPadding),
                    child: controller.selectedItems.contains(customer)
                        ? Icon(
                            Icons.check_box_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : Icon(
                            Icons.check_box_outline_blank_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                  ),
                Expanded(
                  child: CustomListTile(
                    dense: true,
                    title: customer.name,
                    subtitle: customer.lastActivity.formattedDateTime ?? "",
                    onTap: () {
                      if (controller.isSelectable) {
                        controller.selectItem(customer);
                      } else {
                        Get.toNamed(
                          RouteNames.customerDetailView,
                          arguments: customer,
                          parameters: {'businessId': controller.businessId},
                        );
                      }
                    },
                    onLongPress: () {
                      controller.isSelectable = true;
                      controller.selectItem(customer);
                    },
                    leading: AvatarImageText(
                      name: customer.name,
                      imageUrl: customer.photoUrl,
                    ),
                    trailing: _trailingWidget(customer.credit),
                  ),
                ),
              ],
            );
          });
        },
        separatorBuilder: (_, __) => const Divider(
          height: 0,
          indent: AppSizes.largePadding - 6,
          endIndent: AppSizes.exSmallPadding,
        ),
      );
    });
  }

  Padding _trailingWidget(double credit) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.exSmallPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (credit == 0)
            const Text(
              "Clear",
              style: TextStyle(color: AppColors.darkGray),
            )
          else if (credit.isNegative)
            const Text(
              "Due",
              style: TextStyle(color: AppColors.red),
            )
          else
            const Text(
              "Advance",
              style: TextStyle(color: AppColors.green),
            ),
          Text(
            "Rs. ${credit.toInt()}",
            style: TextStyle(
              color: credit == 0
                  ? AppColors.darkGray
                  : credit.isNegative
                      ? AppColors.red
                      : AppColors.green,
            ),
          ),
        ],
      ),
    );
  }
}
